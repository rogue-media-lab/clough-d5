class Admin::NewsFeedsController < Admin::BaseController
  before_action :set_feed, only: [ :edit, :update, :destroy ]

  def index
    @feeds = NewsFeed.order(created_at: :desc)
    @feed = NewsFeed.new
  end

  def create
    @feed = NewsFeed.new(feed_params)
    if @feed.save
      redirect_to admin_news_feeds_path, notice: "Feed added."
    else
      @feeds = NewsFeed.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def edit
    @feeds = NewsFeed.order(created_at: :desc)
    render :index
  end

  def update
    if @feed.update(feed_params)
      redirect_to admin_news_feeds_path, notice: "Feed updated."
    else
      @feeds = NewsFeed.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @feed.destroy
    redirect_to admin_news_feeds_path, notice: "Feed removed."
  end

  private

  def set_feed
    @feed = NewsFeed.find(params[:id])
  end

  def feed_params
    params.expect(news_feed: [ :name, :url, :active ])
  end
end
