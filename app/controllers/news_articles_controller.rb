class NewsArticlesController < ApplicationController
  allow_unauthenticated_access
  before_action :set_default_meta_tags

  def show
    @article = NewsArticle.find(params[:id])
    @related = NewsArticle.published.where.not(id: @article.id)
                         .where(source: @article.source)
                         .recent.limit(3)

    article_desc = @article.body.presence || "Read the latest coverage about Andrew Clough for Congress in SC District 5."
    set_meta_tags(
      title: "#{@article.title} — Clough for SC5",
      description: helpers.truncate(helpers.strip_tags(article_desc.to_s), length: 160),
      og: {
        title: @article.title,
        description: helpers.truncate(helpers.strip_tags(article_desc.to_s), length: 160),
        url: news_article_url(@article)
      }
    )
    set_meta_tags(og: { image: @article.image }) if @article.image.present?
  end

  private

  def set_default_meta_tags
    set_meta_tags(
      site: "Clough for SC5",
      reverse: true,
      separator: " | ",
      og: {
        site_name: "Clough for SC5",
        image: "/og-image-a.jpg"
      },
      twitter: {
        card: "summary_large_image",
        site: "@cloughforsc5",
        image: "/og-image-a.jpg"
      }
    )
  end
end
