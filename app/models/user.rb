# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_friendships, class_name: 'Friendship', foreign_key: :user_id

  has_many :passive_friendships, class_name: 'Friendship', foreign_key: :friend_id

  has_many :added_friends, through: :active_friendships,
                           source: :friend

  has_many :adding_friends, through: :passive_friendships, source: :user

  def friends
    added_friends + adding_friends
  end
end
