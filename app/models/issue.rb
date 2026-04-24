class Issue < ApplicationRecord
  has_rich_text :description

  enum :status, { draft: 0, active: 1 }, default: :draft

  scope :active,   -> { where(status: :active) }
  scope :featured, -> { where(featured: true) }

  validates :title, presence: true
  validates :description, presence: true
end
