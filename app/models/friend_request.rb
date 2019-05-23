# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  default_scope { eager_load(:requester).eager_load(:requestee) }

  before_validation :prevent_requesting_existing_friend
  before_save :concatenate_ids

  def accept
    update_attributes(responded: true, accepted: true)
  end

  private

  def concatenate_ids
    self.concatenated = [requester.id, requestee.id].sort.insert(1, "X").join
  end

  def existing_friendship?
    !requester.active_friendships.where('concatenated=?', concatenate_ids).empty? || !requester.passive_friendships.where('concatenated=?', concatenate_ids).empty?
  end

  def prevent_requesting_existing_friend
    errors.add(:requester, :blank, message: "Can't add existing friend") if existing_friendship?
  end
end
