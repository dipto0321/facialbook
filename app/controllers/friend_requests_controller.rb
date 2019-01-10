# frozen_string_literal: true

class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    @requestee = User.find_by(id: params[:friend_request][:requestee_id])

    @requester = current_user

    @friend_request = @requester.active_requests.build(requestee_id: @requestee.id)
    begin
      @friend_request.save
    rescue StandardError => exception
      flash[:danger] = 'You already sent a request'
      redirect_back(fallback_location: root_path)
    else
      flash[:info] = "You added #{@requestee.profile.first_name} as friend. Wait for him/her to respond"
      redirect_back(fallback_location: user_path(@requester))
    end
  end

  def destroy
    @friend_request = FriendRequest.find_by(id: params[:id])
    if @friend_request.delete
      flash[:warning] = 'Request deleted'
    else
      flash[:danger] = 'Request already deleted'
    end
    redirect_back(fallback_location: root_path)
  end
end
