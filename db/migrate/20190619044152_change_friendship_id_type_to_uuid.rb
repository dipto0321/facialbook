class ChangeFriendshipIdTypeToUuid < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :friendships do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE friendships ADD PRIMARY KEY (id);"
  end
end
