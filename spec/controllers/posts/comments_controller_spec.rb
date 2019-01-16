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
            commenter_id: commenter.id,
            body: Faker::Lorem.paragraph(2)
          }, post_id: user_post.id
        }
      }.to change(Comment, :count).by(1)
    end
  end

end
