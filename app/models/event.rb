class Event < ApplicationRecord
  enum :status, { upcoming: 0, past: 1 }

  scope :upcoming, -> { where(status: :upcoming).where("date >= ?", Time.current).order(:date) }
  scope :past, -> { where(status: :past).or(where("date < ?", Time.current)).order(date: :desc) }
  scope :this_week, -> { where(status: :upcoming).where(date: Time.current..1.week.from_now).order(:date) }

  validates :title, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

  # Returns true if the event has coordinates for map display
  def has_coordinates?
    latitude.present? && longitude.present?
  end

  # Returns a Google Maps directions URL
  def directions_url
    return nil unless has_coordinates?
    "https://www.google.com/maps/dir/?api=1&destination=#{latitude},#{longitude}"
  end
end
