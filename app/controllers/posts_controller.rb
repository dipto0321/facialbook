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
  end

  def update
  end

  def destroy
  end
end
