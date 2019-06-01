# frozen_string_literal: true

class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  def create
    @requestee = User.find_by(id: params[:friend_request][:requestee_id])

    @requester = current_user

    @friend_request = FriendRequest.new(requestee_id: @requestee.id, requester_id: @requester.id)

    @origin = session[:return_to]

    begin
      @friend_request.save
    rescue StandardError => e
      flash[:danger] = 'You already sent a request'
    end
    respond_to do |format|
      format.html do
        redirect_to session[:return_to]
        session.delete(:return_to)
      end
      format.js
    end
  end

  def destroy
    @friend_request = FriendRequest.find_by(id: params[:id])
    @origin = session[:return_to]
    flash[:danger] = 'Request already deleted' unless @friend_request.delete
    respond_to do |format|
      format.html do
        redirect_to session[:return_to]
        session.delete(:return_to)
      end
      format.js
    end
  end
end
