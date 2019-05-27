# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!
  def index; end

  def show
    session[:return_to] = request.url
    @profile = @user.profile
    @posts = @user.timeline_posts
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
