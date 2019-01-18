# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    # debugger
    if @comment.save
      flash[:success] = 'Coment submitted'
    else
      flash[:danger] = 'Comment not submitted'
    end
    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Comment updated successfully!'
    else
      flash[:danger] = 'Comment update rejected!'
    end
    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    begin
      @comment.delete
    rescue StandardError => exception
      flash[:danger] = 'You are trying to delete a non-existing comment'
    else
      flash[:warning] = 'Comment deleted.'
    end
    redirect_to session[:return_to]
    session.delete(:return_to)
  end

  private

  def comment_params
    params.require(:comment).permit(:author_id, :body, :comment_pic)
  end
end
