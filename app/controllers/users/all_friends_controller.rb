class Users::AllFriendsController < ApplicationController
  def index
    @user = User.find_by(id:params[:user_id])
    @all_friends = current_user.friends
  end
end
