class AddTaglineAndSummaryToIssues < ActiveRecord::Migration[8.1]
  def change
    add_column :issues, :tagline, :text
    add_column :issues, :summary, :text
  end
end
