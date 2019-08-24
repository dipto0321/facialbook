# frozen_string_literal: true

class ChangeProfileIdTypeToUuid < ActiveRecord::Migration[5.2]
  def up
    add_column :profiles, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    change_table :profiles do |t|
      t.remove :id
      t.rename :uuid, :id
      t.uuid :user_id
    end
    execute 'ALTER TABLE profiles ADD PRIMARY KEY (id);'
    execute 'ALTER TABLE profiles ADD FOREIGN KEY (user_id) REFERENCES users(id);'
  end
end
