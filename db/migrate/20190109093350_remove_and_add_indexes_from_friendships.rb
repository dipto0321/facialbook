class RemoveAndAddIndexesFromFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, %i[user_id friend_id]
    add_index :friendships, %i[user_id friend_id]
  end
end
