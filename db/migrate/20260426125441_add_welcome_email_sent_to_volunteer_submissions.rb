class AddWelcomeEmailSentToVolunteerSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_column :volunteer_submissions, :welcome_email_sent_at, :datetime
  end
end
