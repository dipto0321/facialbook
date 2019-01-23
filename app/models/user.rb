# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy

  # The post is authored by user
  has_many :authored_posts, foreign_key: :author_id, class_name: "Post", dependent: :destroy

  # The post is recieved by the user in his timeline
  has_many :received_posts, as: :postable, class_name: "Post", dependent: :destroy

  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_many :likes, foreign_key: :liker_id, dependent: :destroy

  has_many :active_friendships, class_name: 'Friendship', foreign_key: :user_id

  has_many :passive_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_many :added_friends, through: :active_friendships,
                           source: :friend

  has_many :adding_friends, through: :passive_friendships, source: :user

  # All the request send by the user
  has_many :active_requests, class_name: 'FriendRequest', foreign_key: :requester_id

  # All the request received by the user
  has_many :passive_requests, class_name: 'FriendRequest', foreign_key: :requestee_id

  has_many :requestees, through: :active_requests

  has_many :requesters, through: :passive_requests

  default_scope {eager_load(:profile).eager_load(:active_requests).eager_load(:passive_requests).eager_load(:active_friendships).eager_load(:passive_friendships)}

  accepts_nested_attributes_for :profile, allow_destroy: true
  def friends
    added_friends + adding_friends
  end

  def mutual_friends(friend)
    friends & friend.friends
  end

  def friendships
    Friendship.where('user_id=? OR friend_id=?', id, id)
  end

  def pending_request?(requestee)
    pending = active_requests.where('responded=? AND requestee_id=?', false, requestee.id)[0]
    return false if pending.nil?

    !pending.responded
  end

  def pending_passive_requests
    passive_requests.where('responded=?', false)
  end

  def liked_post
    Post.joins(:likes).where('liker_id=?', id)
  end

  def liked_comment
    Comment.joins(:likes).where('liker_id=?', id)
  end
end
