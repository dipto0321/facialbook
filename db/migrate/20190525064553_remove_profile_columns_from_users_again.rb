# frozen_string_literal: true

class RemoveProfileColumnsFromUsersAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :middle_name
    remove_column :users, :image
  end
end
