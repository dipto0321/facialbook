class ChangeCommentIdToUuid < ActiveRecord::Migration[5.2]
  def up
    add_column :comments, :uuid, :uuid, default: "gen_random_uuid()", null: false
    
    change_table :comments do |t|
      t.remove :id
      t.rename :uuid, :id
      t.uuid :author_id
      t.uuid :commentable_id
    end
    execute "ALTER TABLE comments ADD PRIMARY KEY (id);"
    execute "ALTER TABLE comments ADD FOREIGN KEY (author_id) REFERENCES users(id);"
  end
end
