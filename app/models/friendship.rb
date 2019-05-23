# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  default_scope {eager_load(:user).eager_load(:friend)}

  before_save :concatenate_ids

  def self.find_friendship(user, friend)
    Friendship.where('(friend_id=? AND user_id=?) OR (friend_id=? AND user_id=?)', friend.id, user.id, user.id, friend.id)[0]
  end

  private

  def concatenate_ids
    self.concatenated = [user.id, friend.id].sort.join
  end
end
