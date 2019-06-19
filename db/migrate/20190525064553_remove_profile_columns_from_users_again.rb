# frozen_string_literal: true

class RemoveProfileColumnsFromUsersAgain < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    remove_column :users, :middle_name, :string
    remove_column :users, :image, :string
  end
end
