# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile

  def new
    # @user = User.find_by(id: params[:user_id])
    # if !@user.profile.nil?
    #   flash[:warning] = "You already have a profile"
    #   redirect_to user_path(@user)
    # else
    #   render "new"
    # end
  end

  def edit; end

  def create
    @user = User.find_by(id: params[:user_id])
    @user.profile = profile_params
    if @user.profile.save
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def update
    @user = User.find_by(id: @profile.user_id)
    if @profile.update(profile_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def find_profile
    @profile = Profile.find_by(id: params[:id])
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :birthday, :gender, :bio, :profile_picture)
  end
end
