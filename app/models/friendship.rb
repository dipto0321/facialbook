# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  # attr_reader :find_friendship

  def self.find_friendship(id)
    Friendship.where('friend_id=? OR user_id=?', id, id)[0]
  end
end
