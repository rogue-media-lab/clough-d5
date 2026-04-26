class NewsFeed < ApplicationRecord
  scope :active, -> { where(active: true) }

  validates :name, presence: true
  validates :url, presence: true, uniqueness: true
end
