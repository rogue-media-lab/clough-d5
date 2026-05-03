class CreateContactMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :contact_messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :body
      t.integer :status, default: 0
      t.datetime :read_at

      t.timestamps
    end
  end
end
