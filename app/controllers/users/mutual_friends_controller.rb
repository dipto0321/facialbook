class Users::MutualFriendsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @mutual_friends = current_user.mutual_friends(@user)
  end
end
