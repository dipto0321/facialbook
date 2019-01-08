class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true

end
