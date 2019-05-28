# frozen_string_literal: true

module UsersHelper
  def find_friendship(user1, user2)
    Friendship.between(user1, user2)
  end
end
