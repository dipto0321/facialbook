# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :postable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  default_scope { order(updated_at: :desc).eager_load(:author).eager_load(:likes).eager_load(:comments) }
  mount_uploader :post_pic, PostPicUploader
  validate :post_pic_size
  validates :body, presence: true

  def self.user_newsfeed_posts(postable)
    friend_ids = postable.friends.map(&:id)
    Post.where('postable_id IN (?) OR posts.author_id IN (?)', friend_ids + [postable.id], friend_ids + [postable.id])
  end

  private

  def post_pic_size
    if post_pic.size > 5.megabytes
      errors.add(:post_pic, 'should be less than 5MB')
    end
  end
end
