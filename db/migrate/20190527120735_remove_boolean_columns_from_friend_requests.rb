# frozen_string_literal: true

class RemoveBooleanColumnsFromFriendRequests < ActiveRecord::Migration[5.2]
  def change
    remove_column :friend_requests, :responded, :boolean
    remove_column :friend_requests, :accepted, :boolean
  end
end
