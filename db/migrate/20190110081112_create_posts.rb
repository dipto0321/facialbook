class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :body
      t.string :post_pic
      t.references :postable, polymorphic: true
      t.references :author
      t.timestamps
    end
     add_foreign_key :posts, :users, column: :author_id
  end
end
