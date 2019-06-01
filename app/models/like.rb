# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :liker, class_name: 'User'
  default_scope { preload(:likeable).preload(:liker) }
end
