class RemoveAndAddIndexesFromFriendRequests < ActiveRecord::Migration[5.2]
  def change
    remove_index :friend_requests, %i[requester_id requestee_id]
    add_index :friend_requests, %i[requester_id requestee_id]
  end
end
