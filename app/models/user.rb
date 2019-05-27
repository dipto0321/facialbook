# frozen_string_literal: true

# User model
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_one :profile, dependent: :destroy

  delegate :first_name, :last_name, :middle_name, :full_name, :birthday, :gender, to: :profile
  # The post is authored by user
  has_many :authored_posts, foreign_key: :author_id, class_name: "Post", dependent: :destroy

  # The post is recieved by the user in his timeline
  has_many :received_posts, as: :postable, class_name: "Post", dependent: :destroy

  has_many :comments, foreign_key: :author_id, dependent: :destroy

  has_many :likes, foreign_key: :liker_id, dependent: :destroy

  has_many :active_friendships, class_name: "Friendship", foreign_key: :user_id, dependent: :destroy

  has_many :passive_friendships, class_name: "Friendship", foreign_key: :friend_id, dependent: :destroy

  has_many :added_friends, through: :active_friendships,
                           source: :friend, dependent: :destroy

  has_many :adding_friends, through: :passive_friendships, source: :user, dependent: :destroy

  # All the request send by the user
  has_many :active_requests, class_name: "FriendRequest", foreign_key: :requester_id, dependent: :destroy

  # All the request received by the user
  has_many :passive_requests, class_name: "FriendRequest", foreign_key: :requestee_id, dependent: :destroy

  has_many :requestees, through: :active_requests

  has_many :requesters, through: :passive_requests

  default_scope do
    eager_load(:profile)
      .eager_load(:active_requests)
      .eager_load(:passive_requests)
      .eager_load(:active_friendships)
      .eager_load(:passive_friendships)
  end

  accepts_nested_attributes_for :profile, allow_destroy: true

  before_validation :force_profile_creation

  def friends
    added_friends + adding_friends
  end

  def mutual_friends(friend)
    friends & friend.friends
  end

  def friendships
    Friendship.where("user_id=? OR friend_id=?", id, id)
  end

  def has_pending_request_to?(requestee)
    !active_requests.where("requestee_id=?", requestee.id).empty?
  end

  def has_pending_request_from?(requester)
    !passive_requests.where("requester_id=?", requester.id).empty?
  end

  def newsfeed_posts
    friend_ids = friends.map(&:id)
    combined_ids = friend_ids + [id]
    Post.where("postable_id IN (?) OR posts.author_id IN (?)", combined_ids, combined_ids)
  end

  def timeline_posts
    Post.where('postable_id=? OR posts.author_id=?', id, id)
  end

  def liked_post
    Post.joins(:likes).where("liker_id=?", id)
  end

  def liked_comment
    Comment.joins(:likes).where("liker_id=?", id)
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.facebook_data"]) && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.build_profile
      parse_name(user, auth.info.name) # assuming the user model has a name
    end
  end

  private

  def force_profile_creation
    errors.add(:profile, :blank, message: "can't be nil") if profile.nil?
  end

  private_class_method def self.parse_name(user, name)
    name_arr = name.split(" ")
    user.profile.last_name = name_arr.pop
    user.profile.middle_name = name_arr.last
    user.profile.first_name = name_arr.first
  end
end
