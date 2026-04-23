class CreateNewsArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :body
      t.string :external_url
      t.string :image
      t.string :source
      t.datetime :published_date
      t.integer :status
      t.boolean :featured

      t.timestamps
    end
  end
end
