# frozen_string_literal: true

class Users::AllFriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find_by(id: params[:user_id])
    @all_friends = @user.friends
    session[:return_to] = request.url
  end
end
