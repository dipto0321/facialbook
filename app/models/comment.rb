# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: 'User'
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  default_scope { order(created_at: :desc).eager_load(:author).eager_load(:likes) }
  validates :body, presence: true
end
