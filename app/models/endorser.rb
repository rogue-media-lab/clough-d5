class Endorser < ApplicationRecord
  scope :active, -> { where(active: true) }
  scope :ordered, -> { order(sort_order: :asc, created_at: :desc) }

  validates :name, presence: true
  validates :quote, presence: true

  CATEGORIES = [
    "Business Leaders",
    "Community Organizations",
    "Veterans",
    "Education",
    "Faith Leaders",
    "Elected Officials",
    "Other"
  ].freeze

  validates :category, inclusion: { in: CATEGORIES, allow_blank: true }
end
