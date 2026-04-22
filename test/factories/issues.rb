FactoryBot.define do
  factory :issue do
    title { "MyString" }
    description { "MyText" }
    icon { "MyString" }
    status { 1 }
    position { 1 }
    featured { false }
  end
end
