class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :postable, polymorphic: true
  default_scope { order(updated_at: :desc) }

  def self.timeline_posts(postable)
    Post.where("postable_id=?",postable.id)
  end

  def self.newsfeed_posts(postable)
    
  end
end
