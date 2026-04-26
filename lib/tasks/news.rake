require "rss"
require "open-uri"

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

          NewsArticle.create!(
            title: title,
            body: description,
            external_url: url,
            source: feed.name,
            published_date: pub_date,
            status: :draft  # Draft until reviewed
          )
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
end
