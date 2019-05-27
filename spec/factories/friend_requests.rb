# frozen_string_literal: true

FactoryBot.define do
  factory :friend_request do
    association :requester, factory: :user
    association :requestee, factory: :user
  end
end
