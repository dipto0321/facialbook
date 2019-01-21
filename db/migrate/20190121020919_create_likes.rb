# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.references :liker

      t.timestamps
    end
    add_foreign_key :likes, :users, column: :liker_id
  end
end
