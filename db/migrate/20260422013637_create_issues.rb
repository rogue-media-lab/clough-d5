class CreateIssues < ActiveRecord::Migration[8.1]
  def change
    create_table :issues do |t|
      t.string :title
      t.text :description
      t.string :icon
      t.integer :status
      t.integer :position
      t.boolean :featured

      t.timestamps
    end
  end
end
