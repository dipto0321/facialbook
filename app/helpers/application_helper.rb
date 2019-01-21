# frozen_string_literal: true

module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def image_url(resource)
    image_url = resource.profile_picture? ? resource.profile_picture.url : 'https://www.lewesac.co.uk/wp-content/uploads/2017/12/default-avatar.jpg'
  end
end
