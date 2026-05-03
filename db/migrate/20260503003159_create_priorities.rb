class CreatePriorities < ActiveRecord::Migration[8.1]
  def change
    create_table :priorities do |t|
      t.string :title
      t.text :description
      t.string :icon
      t.boolean :show_icon, default: true
      t.integer :position
      t.boolean :active, default: true
      t.references :linked_issue, foreign_key: { to_table: :issues }, null: true

      t.timestamps
    end
  end
end
