class CreateIssueNewsArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :issue_news_articles do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :news_article, null: false, foreign_key: true

      t.timestamps
    end

    add_index :issue_news_articles, [ :issue_id, :news_article_id ], unique: true
  end
end
