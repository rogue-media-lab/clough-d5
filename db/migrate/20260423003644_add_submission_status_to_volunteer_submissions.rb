class AddSubmissionStatusToVolunteerSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_column :volunteer_submissions, :submission_status, :integer
  end
end
