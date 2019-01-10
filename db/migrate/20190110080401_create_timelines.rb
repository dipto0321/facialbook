class CreateTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :timelines do |t|
      t.references :owner
      t.timestamps
    end
    add_foreign_key :timelines, :users, column: :owner_id
  end
end
