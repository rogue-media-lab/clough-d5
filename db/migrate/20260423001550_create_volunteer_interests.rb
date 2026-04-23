class CreateVolunteerInterests < ActiveRecord::Migration[8.1]
  def change
    create_table :volunteer_interests do |t|
      t.string :name

      t.timestamps
    end
  end
end
