# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :commenter, class_name: 'User'
  has_many :comments, as: :commentable
  default_scope { order(created_at: :desc) }
  validates :body, presence: true
end
