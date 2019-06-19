class ChangeUserIdTypeToUuid < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :uuid, :uuid, default:"gen_random_uuid()", null: false
    
    change_table :friendships do |t|
      t.remove  :user_id
      t.remove :friend_id
    end
    
    change_table :friend_requests do |t|
      t.remove  :requester_id
      t.remove :requestee_id
    end
    
    change_table :posts do |t|
      t.remove  :author_id
    end
    
    change_table :profiles do |t|
      t.remove  :user_id
    end
    
    change_table :comments do |t|
      t.remove  :author_id
    end
    
    change_table :likes do |t|
      t.remove  :liker_id
    end

    change_table :users do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
  end
end
