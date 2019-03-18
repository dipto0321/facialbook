# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!
  def index; end

  def show
    session[:return_to] = request.url
    if @user.profile.nil?
      if current_user == @user
        flash[:danger] = "Finish creating your profile first"
        redirect_to new_user_profile_path(current_user)
      else
        flash[:danger] = "User hasn't finished creating his/her profile"
        redirect_to root_path
      end
    else
      @profile = @user.profile
      @posts = Post.timeline_posts(@user)
    end
  end

  private

  def find_user
    begin
      @user = User.find(params[:id])
    rescue => exception
      flash[:danger] = "User does not exist"
      redirect_to root_path
    end
  end
end
