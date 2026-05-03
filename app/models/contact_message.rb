class ContactMessage < ApplicationRecord
  enum :status, { unread: 0, read: 1, replied: 2 }

  scope :recent, -> { order(created_at: :desc) }
  scope :unread_first, -> { order(status: :asc, created_at: :desc) }

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :subject, presence: true
  validates :body, presence: true

  def mark_as_read!
    update!(status: :read, read_at: Time.current) if unread?
  end

  def mark_as_replied!
    update!(status: :replied) unless replied?
  end
end
