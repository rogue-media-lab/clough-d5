class NewsArticle < ApplicationRecord
  enum :status, { draft: 0, published: 1 }

  has_many :issue_news_articles, dependent: :destroy
  has_many :issues, through: :issue_news_articles

  scope :published, -> { where(status: :published) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(published_date: :desc, created_at: :desc) }

  validates :title, presence: true
  validates :source, presence: true
end
