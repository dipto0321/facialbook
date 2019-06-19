class ChangeProfileIdTypeToUuid < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :uuid, :uuid, default:"gen_random_uuid()", null: false
    change_table :profiles do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE profiles ADD PRIMARY KEY (id);"
  end
end
