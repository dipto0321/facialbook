class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.text :bio
      t.string :gender
      t.string :profile_picture

      t.timestamps
    end
  end
end
