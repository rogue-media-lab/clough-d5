class PostsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_default_meta_tags

  def index
    @featured_post = Post.published.featured.first
    @posts = Post.published.where.not(id: @featured_post&.id).order(published_at: :desc)
    @news_articles = NewsArticle.published.recent.limit(6)

    set_meta_tags(
      title: "Blog & News — Clough for SC5",
      description: "Latest blog posts, campaign updates, and news coverage for Andrew Clough's campaign for Congress in South Carolina's 5th District.",
      canonical: posts_url,
      og: {
        title: "Blog & News — Clough for SC5",
        description: "Latest blog posts and news coverage for Clough for Congress.",
        url: posts_url
      }
    )
  end

  def show
    @post = Post.published.find(params[:id])

    set_meta_tags(
      title: "#{@post.title} — Clough for SC5",
      description: @post.subtitle.presence || truncate(strip_tags(@post.body.to_s), length: 160),
      og: {
        title: @post.title,
        description: @post.subtitle.presence || "Campaign update from Clough for SC5.",
        url: post_url(@post)
      }
    )
  end

  private

  def set_default_meta_tags
    set_meta_tags(
      site: "Clough for SC5",
      reverse: true,
      separator: " | ",
      og: {
        site_name: "Clough for SC5",
        image: "/og-image.jpg"
      },
      twitter: {
        card: "summary_large_image",
        site: "@cloughforsc5",
        image: "/og-image.jpg"
      }
    )
  end
end
