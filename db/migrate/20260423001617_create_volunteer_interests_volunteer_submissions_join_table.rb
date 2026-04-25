class CreateVolunteerInterestsVolunteerSubmissionsJoinTable < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_interests_volunteer_submissions, id: false do |t|
      t.references :volunteer_interest, null: false, foreign_key: true
      t.references :volunteer_submission, null: false, foreign_key: true
    end
  end
end
