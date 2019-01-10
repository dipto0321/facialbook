# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_profile

  def edit; end

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
