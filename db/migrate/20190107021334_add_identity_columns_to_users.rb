class AddIdentityColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthday, :datetime
    add_column :users, :gender, :string
    add_column :users, :bio, :text
    add_column :users, :profile_picture, :string
  end
end
