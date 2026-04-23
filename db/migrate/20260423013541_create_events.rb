class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :location
      t.string :image
      t.string :google_event_id
      t.integer :status

      t.timestamps
    end
  end
end
