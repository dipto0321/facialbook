class Timeline < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :posts, as: :postable
end
