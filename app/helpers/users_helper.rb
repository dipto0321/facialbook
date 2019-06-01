# frozen_string_literal: true

module UsersHelper
  def find_friendship(user1, user2)
    Friendship.between(user1, user2)
  end

  def button(current, user)
    button_to_show = {}
    if !current.friends.include?(user)
      if !current.has_pending_request_to?(user) && !current.has_pending_request_from?(user)

        button_to_show[:filename] = 'send_friend_request_form'
        button_to_show[:locals] = { user: user, origin: nil }

      elsif current.has_pending_request_to?(user)

        concatenated_ids = [current.id, user.id].sort.insert(1, 'X').join

        request = FriendRequest.where('concatenated=?', concatenated_ids)[0]

        button_to_show[:filename] = 'request_sent_btn'
        button_to_show[:locals] = { request: request }

      elsif current_user.has_pending_request_from?(user)

        button_to_show[:filename] = 'respond_to_friend_request'
        button_to_show[:locals] = { user: user }
      end
    else
      button_to_show[:filename] = 'already_friends_btn'
      button_to_show[:locals] = { user: user }
    end
    button_to_show
  end

  def image_url(user_profile)
    user_profile.profile_picture? ? user_profile.profile_picture.url : 'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg'
  end

  def user_first_n_friends(user, n)
    user.friends.take(n)
  end
end
