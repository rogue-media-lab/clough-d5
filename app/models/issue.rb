class Issue < ApplicationRecord
  enum :status, { draft: 0, active: 1 }, default: :draft

  validates :title, presence: true
  validates :description, presence: true
end
