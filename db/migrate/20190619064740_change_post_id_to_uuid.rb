# frozen_string_literal: true

class ChangePostIdToUuid < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    change_table :posts do |t|
      t.remove :id
      t.rename :uuid, :id
      t.uuid :author_id
      t.uuid :postable_id
    end
    execute 'ALTER TABLE posts ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE posts ADD FOREIGN KEY (author_id) REFERENCES users(id);'
  end
end
