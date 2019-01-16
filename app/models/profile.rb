# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birthday, presence: true
  validates :gender, presence: true
  validate :profile_picture_size

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def profile_picture_size
    if profile_picture.size > 5.megabytes
      errors.add(:profile_picture, 'should be less than 5MB')
    end
  end
end
