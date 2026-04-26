require "rss"
require "net/http"
require "uri"

namespace :news do
  desc "Fetch articles from all active RSS feeds"
  task fetch: :environment do
    feeds = NewsFeed.active
    puts "Fetching #{feeds.count} active feeds..."

    feeds.each do |feed|
      puts "\n  [#{feed.name}] #{feed.url}"
      begin
        # Fetch and parse the feed
        xml = URI.open(feed.url,
          "User-Agent" => "CloughForSC5/1.0",
          read_timeout: 15,
          open_timeout: 10
        ).read

        parsed = RSS::Parser.parse(xml, false)
        next puts "    WARN: Could not parse feed" unless parsed

        items = parsed.items || []
        new_count = 0

        items.first(20).each do |item|
          title = item.title&.strip
          next unless title.present?

          # Build the URL from the feed item
          url = item.link&.strip
          next unless url.present?

          # Skip if we already have this article (match by external_url)
          if NewsArticle.exists?(external_url: url)
            next
          end

          # Extract description/summary
          description = nil
          if item.respond_to?(:description) && item.description.present?
            description = ActionController::Base.helpers.strip_tags(item.description).strip.truncate(500)
          elsif item.respond_to?(:content) && item.content.present?
            description = ActionController::Base.helpers.strip_tags(item.content).strip.truncate(500)
          end

          # Extract published date
          pub_date = item.date rescue nil
          pub_date ||= item.pubDate rescue nil
          pub_date ||= item.dc_date rescue nil
          pub_date ||= Time.current

          # Try to get image from feed item or OG tags
          image_url = nil
          # Check RSS enclosures for media
          if item.respond_to?(:enclosure) && item.enclosure&.url
            image_url = item.enclosure.url
          end
          # Check for media:content
          if image_url.blank? && item.respond_to?(:media_content_url)
            image_url = item.media_content_url rescue nil
          end

          article = NewsArticle.create!(
            title: title,
            body: description,
            external_url: url,
            image: image_url,
            source: feed.name,
            published_date: pub_date,
            status: :draft  # Draft until reviewed
          )

          # Fetch OG image in background if we don't have one yet
          if image_url.blank?
            og_image = fetch_og_image(url)
            article.update(image: og_image) if og_image.present?
          end

          new_count += 1
        end

        puts "    OK: #{new_count} new articles (#{items.count} total in feed)"
      rescue OpenURI::HTTPError => e
        puts "    ERROR: HTTP #{e.message}"
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        puts "    ERROR: Timeout - #{e.message}"
      rescue RSS::NotWellFormedError => e
        puts "    ERROR: Malformed feed - #{e.message}"
      rescue => e
        puts "    ERROR: #{e.class} - #{e.message}"
      end
    end

    puts "\nDone. Total articles: #{NewsArticle.count} (#{NewsArticle.published.count} published, #{NewsArticle.draft.count} drafts)"
  end

  desc "Backfill missing article images by fetching OG tags"
  task backfill_images: :environment do
    articles = NewsArticle.where(image: [nil, ""]).where.not(external_url: [nil, ""])
    puts "Found #{articles.count} articles without images..."

    articles.find_each do |article|
      print "  #{article.title.truncate(50)}... "
      image = fetch_og_image(article.external_url)
      if image.present?
        article.update_column(:image, image)
        puts "OK (#{image.truncate(60)})"
      else
        puts "no image found"
      end
      sleep 0.5 # Be polite to servers
    end

    puts "\nDone. #{NewsArticle.where.not(image: [nil, '']).count}/#{NewsArticle.count} articles have images."
  end
end

# Fetch the Open Graph image from a URL
def fetch_og_image(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  http.open_timeout = 5
  http.read_timeout = 5

  request = Net::HTTP::Get.new(uri.request_uri)
  request["User-Agent"] = "CloughForSC5/1.0"

  response = http.request(request)
  return nil unless response.is_a?(Net::HTTPSuccess)

  # Only read the first 50KB to find meta tags
  html = response.body[0..51200]

  # Look for og:image meta tag
  if html =~ /property=["']og:image["'][^>]*content=["']([^"']+)["']/i
    return $1
  elsif html =~ /content=["']([^"']+)["'][^>]*property=["']og:image["']/i
    return $1
  elsif html =~ /name=["']twitter:image["'][^>]*content=["']([^"']+)["']/i
    return $1
  end

  nil
rescue => e
  nil
end
