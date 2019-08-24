# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }

    after :build do |user|
      user.profile = Profile.new(user_id: user.id,
                                 first_name: Faker::Name.male_first_name,
                                 last_name: Faker::Name.last_name,
                                 gender: 'male',
                                 birthday: Faker::Date.birthday(min_age: 18, max_age: 65))
    end
  end

  factory :invalid_user, class: 'User' do
    email {}
    password { 'password' }
    password_confirmation { 'password' }
  end
end
