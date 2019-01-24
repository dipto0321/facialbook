# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!
  def index; end

  def show
    session[:return_to] = request.url
    begin
      @user.profile
    rescue => exception
      flash[:danger] = "User does not exist"
      redirect_to root_path
    else
      @profile = @user.profile
      @posts = Post.timeline_posts(@user)
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
