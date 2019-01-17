# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true
      t.references :author
      t.text :body
      t.string :comment_pic
      t.timestamps
    end
    add_foreign_key :comments, :users, column: :author_id
  end
end
