# frozen_string_literal: true

class Users::MutualFriendsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find_by(id: params[:user_id])
    @mutual_friends = current_user.mutual_friends(@user)
  end
end
