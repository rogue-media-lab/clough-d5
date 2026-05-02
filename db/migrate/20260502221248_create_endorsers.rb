class CreateEndorsers < ActiveRecord::Migration[8.1]
  def change
    create_table :endorsers do |t|
      t.string :name
      t.string :title
      t.text :quote
      t.string :category
      t.string :photo_url
      t.integer :sort_order, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
