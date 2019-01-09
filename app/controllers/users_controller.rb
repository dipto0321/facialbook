# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :find_user
  def index; end

  def show
    @profile = @user.profile
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end
end
