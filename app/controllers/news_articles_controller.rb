class NewsArticlesController < ApplicationController
  allow_unauthenticated_access

  def show
    @article = NewsArticle.find(params[:id])
    @related = NewsArticle.published.where.not(id: @article.id)
                         .where(source: @article.source)
                         .recent.limit(3)
  end
end
