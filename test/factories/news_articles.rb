FactoryBot.define do
  factory :news_article do
    title { "MyString" }
    body { "MyText" }
    external_url { "MyString" }
    image { "MyString" }
    source { "MyString" }
    published_date { "2026-04-22 21:42:04" }
    status { 1 }
    featured { false }
  end
end
