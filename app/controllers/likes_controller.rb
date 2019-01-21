class LikesController < ApplicationController
  def create
    @like = @likeable.likes.build

    @like.liker_id = current_user.id

    @like.save

    redirect_to session[:return_to]
    session.delete(:return_to)
  end
end
