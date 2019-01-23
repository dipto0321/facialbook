# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def edit
    session[:return_to] = request.referrer
    @post = Post.find_by(id: params[:id])
  end

  def create

    @author = current_user
    @post = @author.authored_posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created!'
    else
      flash[:danger] = 'Post not created!'
    end
    redirect_back(fallback_location: root_path)
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:success] = 'Post updated'
      redirect_to session.delete(:return_to)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    begin
      @post.delete
    rescue StandardError => exception
      flash[:danger] = 'Post already deleted or never existed'
      redirect_to root_path
    else
      flash[:info] = 'Post deleted'
      redirect_to session[:return_to]
      session.delete(:return_to)
    end
  end

  private

  def post_params
    params.require(:post).permit(:postable_id,:postable_type, :user_id, :post_pic, :body)
  end
end
