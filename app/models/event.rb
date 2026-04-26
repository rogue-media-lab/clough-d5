class Event < ApplicationRecord
  enum :status, { upcoming: 0, past: 1 }

  scope :upcoming, -> { where(status: :upcoming).where("date >= ?", Time.current).order(:date) }
  scope :past, -> { where(status: :past).or(where("date < ?", Time.current)).order(date: :desc) }
  scope :this_week, -> { where(status: :upcoming).where(date: Time.current..1.week.from_now).order(:date) }

  validates :title, presence: true
  validates :date, presence: true
  validates :location, presence: true
end
