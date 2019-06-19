# frozen_string_literal: true

class RemoveProfileColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :birthday, :date
    remove_column :users, :bio, :text
    remove_column :users, :profile_picture, :string
    remove_column :users, :gender, :string
  end
end
