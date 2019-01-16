class Comments::CommentsController < CommentsController
  before_action :set_commentable

  private
  def set_commentable
    @commentable = Comment.find_by(id:params[:comment_id])
  end
end