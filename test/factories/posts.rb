FactoryBot.define do
  factory :post do
    title { "MyString" }
    subtitle { "MyString" }
    featured { false }
    published_at { "2026-04-21 21:27:20" }
    user { nil }
  end
end
