class ChangeFriendRequestIdToUuid < ActiveRecord::Migration[5.2]
  def up
    add_column :friend_requests, :uuid, :uuid, default: "gen_random_uuid()", null: false
    
    change_table :friend_requests do |t|
      t.remove :id
      t.rename :uuid, :id
      t.uuid :requester_id
      t.uuid :requestee_id
    end
    execute "ALTER TABLE friend_requests ADD PRIMARY KEY (id);"
    execute "ALTER TABLE friend_requests ADD FOREIGN KEY (requester_id) REFERENCES users(id);"
    execute "ALTER TABLE friend_requests ADD FOREIGN KEY (requestee_id) REFERENCES users(id);"
  end
end
