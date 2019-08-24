# frozen_string_literal: true

FactoryBot.define do
  factory :post_comment, class: 'Comment' do
    commentable_type { 'Post' }
    association :commentable, factory: :post
    association :author, factory: :user
    body { Faker::Lorem.paragraph(sentence_count: 2) }
  end

  factory :comment_reply, class: 'Comment' do
    commentable_type { 'Comment' }
    association :commentable, factory: :comment
    association :author, factory: :user
    body { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
