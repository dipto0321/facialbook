# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :postable, polymorphic: true
  default_scope { order(updated_at: :desc) }
  mount_uploader :post_pic, PostPicUploader

  def self.timeline_posts(postable)
    Post.where('postable_id=? OR author_id=?', postable.id, postable.id)
  end

  def self.user_newsfeed_posts(postable)
    friend_ids = postable.friends.map(&:id)
    Post.where('postable_id IN (?) OR author_id IN (?)', friend_ids + [postable.id], friend_ids + [postable.id])
  end
end
