class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :postable, polymorphic: true
  default_scope { order(updated_at: :desc) }
  
  def self.timeline_posts(postable)
    Post.where("postable_id=?",postable.id)
  end

  def self.user_newsfeed_posts(postable)
    friend_ids = postable.friends.map {|friend| friend.id}
    Post.where("postable_id IN (?) OR author_id=?", friend_ids + [postable.id], postable.id)
  end
end
