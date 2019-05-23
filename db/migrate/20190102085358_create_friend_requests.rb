# frozen_string_literal: true

class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.boolean :responded, default: false
      t.boolean :accepted
      t.references :requester
      t.references :requestee
      t.string :concatenated

      t.timestamps
    end
    add_foreign_key :friend_requests, :users, column: :requester_id
    add_foreign_key :friend_requests, :users, column: :requestee_id
    add_index :friend_requests, %i[requester_id requestee_id], unique: true
    add_index :friend_requests, :concatenated, unique: true
  end
end
