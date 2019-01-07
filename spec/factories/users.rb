# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    first_name {Faker::Name.male_first_name}
    last_name {Faker::Name.last_name}
    gender "male"
    birthday {Faker::Date.birthday(18, 65)}
    bio {Faker::Lorem.sentence(3)}
  end

  factory :invalid_user, class: 'User' do
    email {}
    password { 'password' }
    password_confirmation { 'password' }
    first_name {Faker::Name.last_name}
    gender "male"
    birthday {Faker::Date.birthday(18, 65)}
    bio Faker::Lorem.sentence(3)
  end
end
