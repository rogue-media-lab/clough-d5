class NewsArticle < ApplicationRecord
  has_rich_text :reflection

  has_many :issue_news_articles, dependent: :destroy
  has_many :issues, through: :issue_news_articles

  # 0 = fetched (imported, not live), 1 = published (live on site)
  enum :status, { fetched: 0, published: 1 }

  scope :published, -> { where(status: :published) }
  scope :featured, -> { where(featured: true) }
  scope :recent, -> { order(published_date: :desc, created_at: :desc) }

  validates :title, presence: true
  validates :source, presence: true
end
