# frozen_string_literal: true

class ChangeFriendshipIdToUuid < ActiveRecord::Migration[5.2]
  def up
    add_column :friendships, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    change_table :friendships do |t|
      t.remove :id
      t.rename :uuid, :id
      t.uuid :user_id
      t.uuid :friend_id
    end
    execute 'ALTER TABLE friendships ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE friendships ADD FOREIGN KEY (user_id) REFERENCES users(id);'
    execute 'ALTER TABLE friendships ADD FOREIGN KEY (friend_id) REFERENCES users(id);'
  end
end
