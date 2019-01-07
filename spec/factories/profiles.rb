FactoryBot.define do
  factory :profile do
    user { nil }
    first_name { "MyString" }
    last_name { "MyString" }
    birthday { "2019-01-07 15:24:27" }
    bio { "MyText" }
    gender { "MyString" }
    profile_picture { "MyString" }
  end
end
