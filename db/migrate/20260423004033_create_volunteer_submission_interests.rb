class CreateVolunteerSubmissionInterests < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_submission_interests do |t|
      t.references :volunteer_submission, null: false, foreign_key: true
      t.references :volunteer_interest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
