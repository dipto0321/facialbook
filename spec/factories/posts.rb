# frozen_string_literal: true

FactoryBot.define do
  factory :user_post, class: 'Post' do
    postable_type { 'User' }
    postable_id { 1 }
    author_id { 1 }
    body { Faker::Lorem.paragraph(5) }
  end
end
