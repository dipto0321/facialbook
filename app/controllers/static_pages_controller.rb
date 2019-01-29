# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    session[:return_to] = request.url
    if !current_user.profile.nil?
      @posts = Post.user_newsfeed_posts(current_user) if user_signed_in?
    else
      redirect_to new_user_profile_path(current_user)
    end
  end
end
