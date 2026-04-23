class CreateNewsFeeds < ActiveRecord::Migration[8.1]
  def change
    create_table :news_feeds do |t|
      t.string :name
      t.string :url
      t.boolean :active

      t.timestamps
    end
  end
end
