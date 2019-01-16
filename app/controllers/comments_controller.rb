class CommentsController < ApplicationController
  def edit
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Coment submitted"
    else
      flash[:danger] = "Comment not submitted"
    end
    redirect_to request.referrer
  end

  private 
  def comment_params
    params.require(:comment).permit(:commenter_id, :body, :comment_pic)
  end
end
