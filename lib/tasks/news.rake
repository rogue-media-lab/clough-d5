require "rss"
require "net/http"
require "uri"

# Polite defaults
USER_AGENT = "CloughForSC5 Bot (campaign site; contact: admin@cloughforsc.com)"
REQUEST_DELAY = 1.0  # seconds between any external requests
MAX_ARTICLES_PER_FEED = 10
MAX_OG_FETCHES = 5    # only grab images for first N new articles per run
FEED_OPEN_TIMEOUT = 5  # seconds to establish connection
FEED_READ_TIMEOUT = 10 # seconds to read response

namespace :news do
  desc "Fetch articles from all active RSS feeds"
  task fetch: :environment do
    feeds = NewsFeed.active
    puts "Fetching #{feeds.count} active feeds..."
    puts "Rate limit: #{REQUEST_DELAY}s between requests, max #{MAX_ARTICLES_PER_FEED} articles/feed\n\n"

    og_fetches_remaining = MAX_OG_FETCHES

    feeds.each_with_index do |feed, i|
      # Polite delay between feeds
      sleep REQUEST_DELAY if i > 0

      puts "  [#{feed.name}] #{feed.url}"
      begin
        uri = URI.parse(feed.url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        http.open_timeout = FEED_OPEN_TIMEOUT
        http.read_timeout = FEED_READ_TIMEOUT

        request = Net::HTTP::Get.new(uri.request_uri)
        request["User-Agent"] = USER_AGENT
        request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"

        response = http.request(request)

        # Follow redirects (up to 3)
        redirect_count = 0
        while response.is_a?(Net::HTTPRedirection) && redirect_count < 3
          redirect_url = response["location"]
          redirect_uri = URI.parse(redirect_url)
          http = Net::HTTP.new(redirect_uri.host, redirect_uri.port)
          http.use_ssl = (redirect_uri.scheme == "https")
          http.open_timeout = FEED_OPEN_TIMEOUT
          http.read_timeout = FEED_READ_TIMEOUT
          request = Net::HTTP::Get.new(redirect_uri.request_uri)
          request["User-Agent"] = USER_AGENT
          request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"
          response = http.request(request)
          redirect_count += 1
        end

        if response.is_a?(Net::HTTPTooManyRequests)
          puts "    WARN: Rate limited (429) — skipping"
          next
        end

        unless response.is_a?(Net::HTTPSuccess)
          puts "    ERROR: HTTP #{response.code} #{response.message}"
          next
        end

        parsed = RSS::Parser.parse(response.body, false)
        unless parsed
          puts "    WARN: Could not parse feed"
          next
        end

        items = parsed.items || []
        new_count = 0

        items.first(MAX_ARTICLES_PER_FEED).each do |item|
          title = item.title&.strip
          next unless title.present?

          url = item.link&.strip
          next unless url.present?

          # Deduplicate
          next if NewsArticle.exists?(external_url: url)

          # Extract description
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

          # Check RSS enclosures for media
          image_url = nil
          if item.respond_to?(:enclosure) && item.enclosure&.url
            image_url = item.enclosure.url
          end
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
            status: :draft
          )

          # Only fetch OG images for a few articles to avoid hammering sites
          if image_url.blank? && og_fetches_remaining > 0
            sleep REQUEST_DELAY
            og_image = fetch_og_image(url)
            if og_image.present?
              article.update_column(:image, og_image)
              og_fetches_remaining -= 1
            end
          end

          new_count += 1
        end

        puts "    OK: #{new_count} new articles (#{items.count} in feed)"
      rescue Net::OpenTimeout, Net::ReadTimeout => e
        puts "    ERROR: Timeout"
      rescue RSS::NotWellFormedError => e
        puts "    ERROR: Malformed feed"
      rescue => e
        puts "    ERROR: #{e.class} - #{e.message}"
      end
    end

    puts "\nDone. Total: #{NewsArticle.count} articles (#{NewsArticle.published.count} published, #{NewsArticle.draft.count} drafts)"
  end

  desc "Backfill missing article images by fetching OG tags"
  task backfill_images: :environment do
    articles = NewsArticle.where(image: [ nil, "" ]).where.not(external_url: [ nil, "" ])
    puts "Found #{articles.count} articles without images..."
    puts "Polite mode: #{REQUEST_DELAY}s between requests\n\n"

    articles.find_each.with_index do |article, i|
      sleep REQUEST_DELAY if i > 0
      print "  #{article.title.truncate(50)}... "
      image = fetch_og_image(article.external_url)
      if image.present?
        article.update_column(:image, image)
        puts "OK"
      else
        puts "no image"
      end
    end

    puts "\nDone. #{NewsArticle.where.not(image: [ nil, '' ]).count}/#{NewsArticle.count} have images."
  end
end

def fetch_og_image(url)
  uri = URI.parse(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == "https")
  http.open_timeout = 5
  http.read_timeout = 5

  request = Net::HTTP::Get.new(uri.request_uri)
  request["User-Agent"] = USER_AGENT

  response = http.request(request)
  return nil unless response.is_a?(Net::HTTPSuccess)

  html = response.body[0..51200]

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
