class Post < ApplicationRecord
  belongs_to :user
has_rich_text :body
has_one_attached :cover_image

scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.current).order(published_at: :desc) }
scope :featured,  -> { where(featured: true) }
scope :drafts,    -> { where(published_at: nil) }

def published?
  published_at.present? && published_at <= Time.current
end

def draft?
  !published?
end
end
