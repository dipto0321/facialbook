class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = @likeable.likes.build

    @like.liker_id = current_user.id

    @like.save

    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @like.delete
    redirect_to session[:return_to]
    session.delete(:return_to)
  end
end
