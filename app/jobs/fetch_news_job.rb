class FetchNewsJob < ApplicationJob
  queue_as :default

  def perform
    require "rss"
    require "net/http"
    require "uri"

    user_agent = "CloughForSC5 Bot (campaign site; contact: admin@cloughforsc.com)"
    feeds = NewsFeed.active
    new_count = 0

    feeds.each do |feed|
      begin
        uri = URI.parse(feed.url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        http.open_timeout = 8
        http.read_timeout = 10

        request = Net::HTTP::Get.new(uri.request_uri)
        request["User-Agent"] = user_agent
        request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"

        response = http.request(request)

        # Follow redirects
        redirect_count = 0
        while response.is_a?(Net::HTTPRedirection) && redirect_count < 3
          redirect_uri = URI.parse(response["location"])
          http = Net::HTTP.new(redirect_uri.host, redirect_uri.port)
          http.use_ssl = (redirect_uri.scheme == "https")
          http.open_timeout = 8
          http.read_timeout = 10
          request = Net::HTTP::Get.new(redirect_uri.request_uri)
          request["User-Agent"] = user_agent
          request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"
          response = http.request(request)
          redirect_count += 1
        end

        next if response.is_a?(Net::HTTPTooManyRequests)
        next unless response.is_a?(Net::HTTPSuccess)

        parsed = RSS::Parser.parse(response.body, false)
        next unless parsed

        parsed.items&.first(10)&.each do |item|
          title = item.title&.strip
          url = item.link&.strip
          next unless title.present? && url.present?
          next if NewsArticle.exists?(external_url: url)

          description = nil
          if item.respond_to?(:description) && item.description.present?
            description = ActionController::Base.helpers.strip_tags(item.description).strip.truncate(500)
          end

          pub_date = item.date rescue nil
          pub_date ||= item.pubDate rescue nil
          pub_date ||= Time.current

          image_url = nil
          if item.respond_to?(:enclosure) && item.enclosure&.url
            image_url = item.enclosure.url
          end

          article = NewsArticle.create!(
            title: title,
            body: description,
            external_url: url,
            image: image_url,
            source: feed.name,
            published_date: pub_date,
            status: :fetched
          )

          # Fetch OG image for first few articles
          if image_url.blank? && new_count < 5
            sleep 1
            og_image = fetch_og_image(url, user_agent)
            article.update_column(:image, og_image) if og_image.present?
          end

          new_count += 1
        end
      rescue => e
        Rails.logger.warn "NewsFeed fetch error (#{feed.name}): #{e.message}"
      end

      sleep 1.5 # Polite delay between feeds
    end

    Rails.logger.info "FetchNewsJob: #{new_count} new articles fetched"
  end

  private

  def fetch_og_image(url, user_agent)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")
    http.open_timeout = 5
    http.read_timeout = 5

    request = Net::HTTP::Get.new(uri.request_uri)
    request["User-Agent"] = user_agent

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
  rescue
    nil
  end
end
