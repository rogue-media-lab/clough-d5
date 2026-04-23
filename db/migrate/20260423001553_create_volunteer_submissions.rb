class CreateVolunteerSubmissions < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_submissions do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :message
      t.string :area_code
      t.integer :status

      t.timestamps
    end
  end
end
