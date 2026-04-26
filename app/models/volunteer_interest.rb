class VolunteerInterest < ApplicationRecord
  has_many :volunteer_submission_interests, dependent: :destroy
  has_many :submissions, through: :volunteer_submission_interests, source: :volunteer_submission

  validates :name, presence: true, uniqueness: true
end
