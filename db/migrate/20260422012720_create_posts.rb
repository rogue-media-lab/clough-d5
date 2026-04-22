class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.boolean :featured, default: false, null: false
      t.datetime :published_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :posts, :featured, unique: true, where: "(featured = TRUE)"
  end
end
