# frozen_string_literal: true

FactoryBot.define do
  factory :post_comment, class: 'Comment' do
    commentable_id { 1 }
    commentable_type { 'Post' }
    commenter_id { 1 }
    body { Faker::Lorem.paragraph(2) }
  end

  factory :comment_reply, class: 'Comment' do
    commentable_id { 2 }
    commentable_type { 'Comment' }
    commenter_id { 1 }
    body { Faker::Lorem.paragraph(2) }
  end
end
