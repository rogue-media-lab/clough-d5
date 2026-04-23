class AddLastNameToVolunteerSubmissions < ActiveRecord::Migration[8.1]
  def change
    add_column :volunteer_submissions, :last_name, :string
  end
end
