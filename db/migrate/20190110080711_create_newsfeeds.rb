class CreateNewsfeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :newsfeeds do |t|
      t.references :owner

      t.timestamps
    end
    add_foreign_key :newsfeeds, :users, column: :owner_id
  end
end
