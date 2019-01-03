class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    @requestee = User.find_by(id: params[:friend_request][:requestee_id])

    @requester = current_user

    @friend_request = @requester.active_requests.build(requestee_id: @requestee.id )
    begin
      @friend_request.save
    rescue => exception
      flash[:danger] = 'You already sent a request'
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "You are now friends"
     redirect_back(fallback_location: user_path(@requester))
    end
  end
end
