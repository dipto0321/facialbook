# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #show' do
    before :each do
      @author = create(:user)
      @postable_user = create(:user)
      @post = create(:user_post, author_id: @author.id, postable_id: @postable_user.id)
      sign_in(@author)
      get :show, params: { id: @post.id }
    end

    it 'renders the post show page' do
      expect(response).to render_template('show')
    end

    it 'assigns to @post' do
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe 'POSt #create' do
    it 'saves to the database' do
      author = create(:user)
      postable_user = create(:user)
      sign_in(author)
      expect do
        post :create, params: {
          post: {
            postable_id: postable_user.id,
            author_id: author.id,
            body: Faker::Lorem.paragraph(2)
          }
        }
      end.to change(Post, :count).by(1)
    end

    context 'instance variable assignment and redirection' do
      before :each do
        @author = create(:user)
        @postable_user = create(:user)
        parameters = { params: { post: attributes_for(:user_post, postable_id: @postable_user.id, author_id: @author.id) } }
        sign_in(@author)
        post :create, parameters
      end

      it 'assigns to @postable' do
        expect(assigns(:postable)).to eq(@postable_user)
      end

      it 'assigns to @author' do
        expect(assigns(:author)).to eq(@author)
      end

      it 'redirects successfully' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #edit' do
    before :each do
      @author = create(:user)
      @postable_user = create(:user)
      @post = create(:user_post, author_id: @author.id, postable_id: @postable_user.id)
      sign_in(@author)
      get :edit, params: {
        id: @post.id,
        user_id: @postable_user.id
      }
    end

    it 'assigns to @post' do
      expect(assigns(:post)).to eq(@post)
    end
  end

  describe 'PATCH #update' do
    before :each do
      @author = create(:user)
      @postable_user = create(:user)
      @post = create(:user_post, author_id: @author.id, postable_id: @postable_user.id)
      parameters = { params: { id: @post.id, user_id: @postable_user.id, post: {
        postable_id: @postable_user.id,
        author_id: @author.id,
        body: 'This post has been changed'
      } } }
      sign_in(@author)
      session[:return_to] = root_path
      patch :update, parameters
    end
    it 'updates the post in the database' do
      @post.reload
      expect(@post.body).to include('This post has been changed')
    end
  end

  describe 'DELETE #destroy' do
    it 'removes post from the database' do
      author = create(:user)
      postable = author
      sign_in(author)
      post = create(:user_post, author_id: author.id, postable_id: postable.id)
      expect do
        delete :destroy, params: {
          id: post.id
        }
      end.to change(Post, :count).by(-1)
    end
  end
end
