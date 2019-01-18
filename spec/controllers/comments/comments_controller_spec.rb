# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::CommentsController do
  describe 'post#create' do
    it 'saves to the database' do
      commenter = create(:user)
      user_post = create(:user_post, author_id: commenter.id, postable_id: commenter.id)
      comment = create(:post_comment, commentable_id: user_post.id, author_id: commenter.id)
      session[:return_to] = root_path
      sign_in(commenter)
      expect{
        post :create, params: {
          comment:{
            author_id: commenter.id,
            body: "This is a demo"
          },
          comment_id: comment.id
        }
      }.to change(Comment, :count).by(1)
    end

    context "instance variable assingment and redirection" do
      before(:each) do
        @commenter = create(:user)
        @user_post = create(:user_post, author_id: @commenter.id, postable_id: @commenter.id)
        @comment = create(:post_comment, commentable_id: @user_post.id, author_id: @commenter.id)
        parameters = { params: {
          comment: attributes_for(:comment_reply, author_id: @commenter.id), comment_id: @comment.id
        } }
        session[:return_to] = root_path
        sign_in(@commenter)
        post :create, parameters
      end
      it 'assigns to @comment' do
        expect(assigns(:commentable)).to eq(@comment)
      end

      it 'redirects successfully' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'patch#update' do
    before(:each) do
      @commenter = create(:user)
      @user_post = create(:user_post, author_id: @commenter.id, postable_id: @commenter.id)
      @comment = create(:post_comment, commentable_id: @user_post.id, author_id: @commenter.id)
      @comment_reply = create(:comment_reply,commentable_id: @comment.id, author_id: @commenter.id,body: "This is a comment reply" )
      session[:return_to] = root_path
      sign_in(@commenter)
    end

    context 'successful update' do
      before :each do
        parameters = { params: {
          comment: {
            author_id: @commenter.id,
            body: 'Changed comment'
          }, comment_id: @comment.id, id: @comment_reply.id
        } }
        patch :update, parameters
      end

      it 'updates the comment' do
        expect(Comment.first.body).to_not eq(@comment_reply.body)
      end
      it 'redirects successfully' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'unsuccessful update' do
      before :each do
        parameters = { params: {
          comment: {
            author_id: @commenter.id,
            body: nil
          }, comment_id: @comment.id, id: @comment_reply.id
        } }
        patch :update, parameters
      end

      it "doesn't change the comment" do
        expect(@comment_reply.body).to eq('This is a comment reply')
      end

      it 'shows a flash danger' do
        expect(flash[:danger]).to match('Comment update rejected!')
      end
    end
  end

  describe "delete#destroy" do
    it 'removes the comment from the database' do
      @commenter = create(:user)
      @user = create(:user)
      @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      @comment = create(:post_comment, author_id: @commenter.id, commentable_id: @user_post.id)
      @comment_reply = create(:comment_reply,commentable_id: @comment.id, author_id: @commenter.id)
      session[:return_to] = root_path
      sign_in(@commenter)
      expect do
        delete :destroy, params: { id: @comment_reply.id, comment_id: @comment.id }
      end.to change(Comment, :count).by(-1)
    end
  end
end
