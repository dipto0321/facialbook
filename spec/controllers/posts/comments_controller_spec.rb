require 'rails_helper'

RSpec.describe Posts::CommentsController do

  describe "POST #create" do
    it "saves to the database" do
      commenter = create(:user)
      user_post = create(:user_post,author_id: commenter.id, postable_id: commenter.id)
      session[:return_to] = root_path
      sign_in(commenter)
      expect{
        post :create, params: {
          comment:{
            author_id: commenter.id,
            body: Faker::Lorem.paragraph(2)
          }, post_id: user_post.id
        }
      }.to change(Comment, :count).by(1)
    end

    context 'instance variable assingment and redirection' do
      before(:each) do
        @commenter = create(:user)
        @user_post = create(:user_post,author_id: @commenter.id, postable_id: @commenter.id)
        parameters = {params: {
            comment: attributes_for(:post_comment, author_id: @commenter.id), post_id: @user_post.id
          }
        }
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
end
