class RemoveIndexesFromFriendRequestsAndFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friend_requests, %i[requester_id requestee_id]
    remove_index :friendships, %i[user_id friend_id]
  end
end
