# frozen_string_literal: true

module PostsHelper
  def postable(user)
    params[:controller] == 'static_pages' ? current_user : user
  end
end
