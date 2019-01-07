FactoryBot.define do
  factory :profile do
    user_id { 1 }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday(18, 65) }
    bio { Faker::Lorem.sentence(3) }
    gender { 'male' }
  end

  factory :invalid_profile, class: 'Profile' do
    user_id { 1 }
    first_name {  }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday(18, 65) }
    bio { Faker::Lorem.sentence(3) }
    gender { 'female' }
  end
end
