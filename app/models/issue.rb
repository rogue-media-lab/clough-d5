class Issue < ApplicationRecord
  has_rich_text :description
  has_many :issue_news_articles, dependent: :destroy
  has_many :news_articles, through: :issue_news_articles

  enum :status, { draft: 0, active: 1 }, default: :draft

  scope :active,   -> { where(status: :active) }
  scope :featured, -> { where(featured: true) }

  validates :title, presence: true
  validates :description, presence: true
  validates :position, numericality: { greater_than: 0, only_integer: true }
  validate :unique_position

  private

  def unique_position
    return if position.blank?

    conflict = Issue.where(position: position)
      .where.not(id: id)
      .exists?

    if conflict
      errors.add(:position, "is already used by another issue. Positions must be unique.")
    end
  end
end
