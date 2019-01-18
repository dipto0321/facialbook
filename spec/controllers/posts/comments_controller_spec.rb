# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CommentsController do
  describe 'POST #create' do
    it 'saves to the database' do
      commenter = create(:user)
      user_post = create(:user_post, author_id: commenter.id, postable_id: commenter.id)
      session[:return_to] = root_path
      sign_in(commenter)
      expect do
        post :create, params: {
          comment: {
            author_id: commenter.id,
            body: Faker::Lorem.paragraph(2)
          }, post_id: user_post.id
        }
      end.to change(Comment, :count).by(1)
    end

    context 'instance variable assingment and redirection' do
      before(:each) do
        @commenter = create(:user)
        @user_post = create(:user_post, author_id: @commenter.id, postable_id: @commenter.id)
        parameters = { params: {
          comment: attributes_for(:post_comment, author_id: @commenter.id), post_id: @user_post.id
        } }
        session[:return_to] = root_path
        sign_in(@commenter)
        post :create, parameters
      end

      it 'assigns to @comment' do
        expect(assigns(:commentable)).to eq(@user_post)
      end

      it 'redirects successfully' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      @commenter = create(:user)
      @user = create(:user)
      @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      @comment = create(:post_comment, author_id: @commenter.id, commentable_id: @user_post.id, body: 'Wowowee')
      session[:return_to] = root_path
      sign_in(@commenter)
    end

    context 'successful update' do
      before :each do
        parameters = { params: {
          comment: {
            author_id: @commenter.id,
            body: 'Changed comment'
          }, post_id: @user_post.id, id: @comment.id
        } }
        patch :update, parameters
      end

      it 'updates the comment' do
        expect(Comment.first.body).to_not eq(@comment.body)
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
          }, post_id: @user_post.id, id: @comment.id
        } }
        patch :update, parameters
      end

      it "doesn't change the comment" do
        expect(@comment.body).to eq('Wowowee')
      end

      it 'shows a flash danger' do
        expect(flash[:danger]).to match('Comment update rejected!')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'removes the comment from the database' do
      @commenter = create(:user)
      @user = create(:user)
      @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      @comment = create(:post_comment, author_id: @commenter.id, commentable_id: @user_post.id)
      session[:return_to] = root_path
      sign_in(@commenter)
      expect do
        delete :destroy, params: { id: @comment.id, post_id: @user_post.id }
      end.to change(Comment, :count).by(-1)
    end
  end
end
