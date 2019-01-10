# frozen_string_literal: true

class RemoveProfileColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :birthday
    remove_column :users, :bio
    remove_column :users, :profile_picture
    remove_column :users, :gender
  end
end
