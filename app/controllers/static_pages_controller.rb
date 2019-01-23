# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    session[:return_to] = request.url
    @posts = Post.user_newsfeed_posts(current_user) if user_signed_in?
  end
end
