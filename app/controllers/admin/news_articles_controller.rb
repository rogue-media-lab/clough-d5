class Admin::NewsArticlesController < Admin::BaseController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = NewsArticle.recent
    @articles = @articles.where(status: params[:status]) if params[:status].present?
    @articles = @articles.where(featured: true) if params[:featured] == "1"
    @articles = @articles.where(source: params[:source]) if params[:source].present?
    @sources = NewsArticle.distinct.pluck(:source).compact.sort
  end

  def show
  end

  def new
    @article = NewsArticle.new
  end

  def create
    @article = NewsArticle.new(article_params)
    if @article.save
      redirect_to admin_news_article_path(@article), notice: "Article created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to admin_news_article_path(@article), notice: "Article updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_news_articles_path, notice: "Article deleted."
  end

  def fetch_feeds
    # Run the fetch in-process (fast enough for RSS parsing)
    require "rss"
    require "net/http"
    require "uri"

    feeds = NewsFeed.active
    new_count = 0
    errors = []

    feeds.each do |feed|
      begin
        uri = URI.parse(feed.url)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = (uri.scheme == "https")
        http.open_timeout = 10
        http.read_timeout = 15

        request = Net::HTTP::Get.new(uri.request_uri)
        request["User-Agent"] = "CloughForSC5 Bot (campaign site)"
        request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"

        response = http.request(request)

        # Follow redirects
        redirect_count = 0
        while response.is_a?(Net::HTTPRedirection) && redirect_count < 3
          redirect_uri = URI.parse(response["location"])
          http = Net::HTTP.new(redirect_uri.host, redirect_uri.port)
          http.use_ssl = (redirect_uri.scheme == "https")
          http.open_timeout = 10
          http.read_timeout = 15
          request = Net::HTTP::Get.new(redirect_uri.request_uri)
          request["User-Agent"] = "CloughForSC5 Bot (campaign site)"
          request["Accept"] = "application/rss+xml, application/xml, text/xml, */*"
          response = http.request(request)
          redirect_count += 1
        end

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

          NewsArticle.create!(
            title: title,
            body: description,
            external_url: url,
            image: image_url,
            source: feed.name,
            published_date: pub_date,
            status: :fetched
          )
          new_count += 1
        end
      rescue => e
        errors << "#{feed.name}: #{e.message}"
      end
    end

    if new_count > 0
      redirect_to admin_news_articles_path(status: :fetched), notice: "Fetched #{new_count} new articles from #{feeds.count} feeds."
    else
      redirect_to admin_news_articles_path, notice: "No new articles found.#{errors.any? ? " Errors: #{errors.join(', ')}" : ''}"
    end
  end

  def bulk_publish
    articles = NewsArticle.where(id: params[:article_ids])
    count = articles.update_all(status: :published)
    redirect_to admin_news_articles_path, notice: "Published #{count} articles."
  end

  def bulk_unpublish
    articles = NewsArticle.where(id: params[:article_ids])
    count = articles.update_all(status: :fetched)
    redirect_to admin_news_articles_path, notice: "Unpublished #{count} articles."
  end

  def bulk_delete
    articles = NewsArticle.where(id: params[:article_ids])
    count = articles.count
    articles.destroy_all
    redirect_to admin_news_articles_path, notice: "Deleted #{count} articles."
  end

  private

  def set_article
    @article = NewsArticle.find(params[:id])
  end

  def article_params
    params.expect(news_article: [ :title, :body, :external_url, :image, :source, :published_date, :status, :featured, :reflection ])
  end
end
