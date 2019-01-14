class PostsController < ApplicationController
  before_action :authenticate_user!

  def show
    @post = Post.find_by(id:params[:id])
  end

  def edit
    session[:return_to] ||= request.referer
    @post = Post.find_by(id:params[:id])
  end

  def create
    @postable = User.find_by(id: params[:post][:postable_id])
    @author = User.find_by(id: params[:post][:author_id])
    @post = @author.build_post(@postable)
    @post.body = params[:post][:body]
    @post.post_pic = params[:post][:post_pic]

    if @post.save
      flash[:success] = "Post created!"
    else
      flash[:danger] = "Post not created!"
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @postable = User.find_by(id: params[:post][:postable_id])
    @author = User.find_by(id: params[:post][:author_id])
    @post = Post.find_by(id: params[:id])

    @post.body = params[:post][:body]
    @post.post_pic = params[:post][:post_pic]

    if @post.save
      flash[:success] = "Post updated"
      redirect_to session.delete(:return_to)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    begin
      @post.delete
    rescue => exception
      flash[:danger] = "Post already deleted or never existed"
    else
      flash[:info] = "Post deleted"
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def post_params
    params.require(:post).permit(:author_id, :user_id, :post_pic, :body)
  end

end
