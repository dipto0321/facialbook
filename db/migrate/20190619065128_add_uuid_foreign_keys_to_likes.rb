class AddUuidForeignKeysToLikes < ActiveRecord::Migration[5.2]
  def up
    change_table :likes do |t|
      t.uuid :liker_id
      t.uuid :likeable_id
    end
    execute "ALTER TABLE likes ADD FOREIGN KEY (liker_id) REFERENCES users(id);"
  end
end
