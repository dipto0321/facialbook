# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :invalid_user, class: 'User' do
    email {}
    password { 'password' }
    password_confirmation { 'password' }
  end
end
