class ChangeFriendRequestIdTypeToUuid < ActiveRecord::Migration[5.2]
  def change
    add_column :friend_requests, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :friend_requests do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE friend_requests ADD PRIMARY KEY (id);"
  end
end
