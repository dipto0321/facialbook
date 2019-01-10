# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
