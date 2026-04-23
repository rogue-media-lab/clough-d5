FactoryBot.define do
  factory :volunteer_submission do
    name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    message { "MyText" }
    area_code { "MyString" }
    status { 1 }
  end
end
