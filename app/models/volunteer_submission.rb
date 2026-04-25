class VolunteerSubmission < ApplicationRecord
  enum :submission_status, { pending: 0, contacted: 1, confirmed: 2, inactive: 3 }, default: :pending

  has_many :volunteer_submission_interests, dependent: :destroy
  has_many :interests, through: :volunteer_submission_interests, source: :volunteer_interest

  validates :name, presence: true
  validates :email, presence: true
end
