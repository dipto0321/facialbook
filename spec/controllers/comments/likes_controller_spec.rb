# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::LikesController do
  describe "GET #index" do
    it "assigns to @likes" do
      @user = create(:user)
      @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      @liker = create(:user)
      @comment = create(:post_comment, author_id: @liker.id, commentable_id: @user_post.id)
      @like1 = create(:comment_like, liker_id: @liker.id, likeable_id: @comment.id)
      @like2 = create(:comment_like, liker_id: @user.id, likeable_id: @comment.id)
      sign_in(@user)
      get :index, params:{comment_id: @comment.id}
      expect(assigns(:likes)).to eq(@comment.likes)
    end

    it "shows an accurate likes count" do
      expect(assigns(:likes).count).to eq(@comment.likes.count)
    end
  end

  describe 'POST #create' do
    it 'saves to the database' do
      user = create(:user)
      user_post = create(:user_post, author_id: user.id, postable_id: user.id)
      post_comment = create(:post_comment, author_id: user.id, commentable_id: user_post.id)
      liker = create(:user)
      sign_in(user)
      session[:return_to] = root_path
      expect do
        post :create, params: {
          comment_id: post_comment.id
        }
      end.to change(Like, :count).by(1)
    end

    context 'likeable assignment and redirection after' do
      before :each do
        @user = create(:user)
        @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
        @post_comment = create(:post_comment, author_id: @user.id, commentable_id: @user_post.id)
        @liker = create(:user)
        parameters = { params: { comment_id: @post_comment.id } }
        sign_in(@user)
        session[:return_to] = root_path
        post :create, parameters
      end

      it 'asssigns to likeable' do
        expect(assigns(:likeable)).to eq(@post_comment)
      end

      it 'redirects after successful like' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'Delete #destroy' do
    it 'removes the like from the database' do
      @user = create(:user)
      @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      @post_comment = create(:post_comment, author_id: @user.id, commentable_id: @user_post.id)
      @liker = create(:user)
      @like = create(:comment_like, liker_id: @liker.id, likeable_id: @post_comment.id)
      sign_in(@user)
      session[:return_to] = root_path
      expect do
        delete :destroy, params: {
          id: @like.id, comment_id: @post_comment.id
        }
      end.to change(Like, :count).by(-1)
    end
  end
end
