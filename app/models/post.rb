class Post < ApplicationRecord
  belongs_to :author, class_name: "User"
  belongs_to :postable, polymorphic: true
  default_scope { order(updated_at: :desc) }
end
