class IssueNewsArticle < ApplicationRecord
  belongs_to :issue
  belongs_to :news_article
end
