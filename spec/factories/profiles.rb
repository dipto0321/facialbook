# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    association :user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    bio { Faker::Lorem.sentence(word_count: 3) }
    gender { 'male' }
  end

  factory :invalid_profile, class: 'Profile' do
    association :user
    first_name {}
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    bio { Faker::Lorem.sentence(word_count: 3) }
    gender { 'female' }
  end
end
