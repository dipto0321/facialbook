class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find_by(id:params[:id])
  end

  def new
  end

  def edit
  end

  def create
    @postable = User.find_by(id: params[:post][:postable_id])
    @author = User.find_by(id: params[:post][:author_id])
    @post = @postable.build_post(@author)
    @post.body = params[:post][:body]
    @post.post_pic = params[:post][:post_pic]

    @post.save
    redirect_back(fallback_location: root_path)
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:author_id, :user_id, :post_pic, :body)
  end

end
