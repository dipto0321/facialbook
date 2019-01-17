class CommentsController < ApplicationController
  before_action :authenticate_user!
  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Coment submitted"
    else
      flash[:danger] = "Comment not submitted"
    end
    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    @comment.update(comment_params)
    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  private 
  def comment_params
    params.require(:comment).permit(:author_id, :body, :comment_pic)
  end
end
