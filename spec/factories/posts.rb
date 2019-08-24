# frozen_string_literal: true

FactoryBot.define do
  factory :user_post, class: 'Post' do
    postable_type { 'User' }
    association :postable, factory: :user
    association :author, factory: :user
    body { Faker::Lorem.paragraph(sentence_count: 5) }
  end
end
