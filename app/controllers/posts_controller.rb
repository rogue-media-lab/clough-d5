class PostsController < ApplicationController
  allow_unauthenticated_access

  def index
    @featured_post = Post.published.featured.first
    @posts = Post.published.where.not(id: @featured_post&.id).order(published_at: :desc)
    @news_articles = NewsArticle.published.recent.limit(6)
  end

  def show
    @post = Post.published.find(params[:id])
  end
end
