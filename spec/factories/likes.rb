# frozen_string_literal: true

FactoryBot.define do
  factory :post_like, class: 'Like' do
    likeable_type { 'Post' }
    association :likeable, factory: :post
    association :liker, factory: :user
  end

  factory :comment_like, class: 'Like' do
    likeable_type { 'Comment' }
    association :likeable, factory: :comment
    association :liker, factory: :user
  end
end
