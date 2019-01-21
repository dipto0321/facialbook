require "rails_helper"

RSpec.describe Posts::LikesController do

  describe "POST #create" do
    it "saves to the database" do
      user = create(:user)
      user_post = create(:user_post, author_id: user.id, postable_id: user.id)
      liker = create(:user)
      sign_in(user)
      session[:return_to] = root_path
      expect{
        post :create, params: {
          post_id: user_post.id
        }
      }.to change(Like, :count).by(1)
    end

    context "likeable assignment and redirection after" do
      before :each do
        @user = create(:user)
        @user_post = create(:user_post, author_id: @user.id, postable_id: @user.id)
        @liker = create(:user)
        parameters = {params:{post_id: @user_post.id}}
      sign_in(@user)
      session[:return_to] = root_path
      post :create, parameters
      end

      it "asssigns to likeable" do
        expect(assigns(:likeable)).to eq(@user_post)
      end

      it "redirects after successful like" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

end