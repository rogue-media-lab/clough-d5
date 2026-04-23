FactoryBot.define do
  factory :event do
    title { "MyString" }
    description { "MyText" }
    date { "2026-04-22 21:35:41" }
    location { "MyString" }
    image { "MyString" }
    google_event_id { "MyString" }
    status { 1 }
  end
end
