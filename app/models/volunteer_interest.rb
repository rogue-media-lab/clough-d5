class VolunteerInterest < ApplicationRecord
  has_many :volunteer_submission_interests, dependent: :destroy
  has_many :submissions, through: :volunteer_submission_interests, class_name: "VolunteerSubmission"

  validates :name, presence: true, uniqueness: true
end