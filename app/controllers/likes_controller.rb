# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    @likes = @likeable.likes
  end

  def create
    @like = @likeable.likes.build

    @like.liker_id = current_user.id

    @likeable = @like.likeable

    @like.save
    respond_to do |format|
      format.html do
        redirect_to session[:return_to]
        session.delete(:return_to)
      end
      format.js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @likeable = @like.likeable
    @like.delete
    respond_to do |format|
      format.html do
        redirect_to session[:return_to]
        session.delete(:return_to)
      end
      format.js
    end
  end
end
