class Admin::NewsFeedsController < Admin::BaseController
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

  def destroy
    feed = NewsFeed.find(params[:id])
    feed.destroy
    redirect_to admin_news_feeds_path, notice: "Feed removed."
  end

  private

  def feed_params
    params.expect(news_feed: [ :name, :url, :active ])
  end
end
