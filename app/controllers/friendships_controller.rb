# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by(id: params[:friendship][:user_id])
    @friend = current_user

    @friendship = @user.active_friendships.build(friend_id: @friend.id)

    begin
      @friendship.save
    rescue => exception
      flash[:danger] = 'You are already friends'
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "You are now friends"
     redirect_back(fallback_location: user_path(@user))
    end
  end

  def destroy
    @friendship = Friendship.find_by(id: params[:id])
    if @friendship.delete
      flash[:warning] = "Friend removed"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "Friend already deleted"
      redirect_back(fallback_location: root_path)
    end
  end

end
