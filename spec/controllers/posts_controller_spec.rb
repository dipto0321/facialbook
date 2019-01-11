require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #show" do
    before :each do
      @author = create(:user)
      @postable_user = create(:user)
      @post = create(:user_post, author_id: @author.id, postable_id: @postable_user.id)
      sign_in(@author)
      get :show, params:{id:@post.id}
    end

    it "renders the post show page" do
      expect(response).to render_template("show")
    end

    it "assigns to @post" do
      expect(assigns(:post)).to eq(@post)
    end
  end


  describe "GET #new" do
    
  end

  describe "GET #edit" do
    
  end

end
