class PostsController < ApplicationController
  allow_unauthenticated_access

  def index
    @featured_post = Post.published.featured.first
    @posts = Post.published.where.not(id: @featured_post&.id).order(published_at: :desc)
    @featured_issues = Issue.active.featured.order(position: :asc)
    @active_issues = Issue.active.order(position: :asc)
  end

  def show
    @post = Post.published.find(params[:id])
  end
end
