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
    FetchNewsJob.perform_later
    redirect_to admin_news_articles_path, notice: "Fetch started in background. Refresh in a moment to see new articles."
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
