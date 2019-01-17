require 'rails_helper'

feature "create new comment on post" do
  before :each do
    visit root_path
    @current_user = create(:user)
    @friend = create(:user)
    create(:friendship, friend_id: @friend.id, user_id: @current_user.id)
    @post = create(:user_post, author_id: @current_user.id, postable_id: @current_user.id)
    within "#navbarSupportedContent" do
      fill_in "Email", with: @current_user.email
      fill_in "Password", with: @current_user.password
      click_on "Log in"
    end

  end

  context "posting from home page" do
    before :each do
      @comment_body = Faker::Lorem.paragraph(2)
      fill_in "comment_body", with: @comment_body
      click_on "Create Comment"
    end

    it "shows the comment created in the post" do
      expect(page).to have_content(@comment_body)
    end
  end

  context "posting from user page" do
    before :each do
      visit user_path(@friend)
      @comment_body = Faker::Lorem.paragraph(2)
      fill_in "comment_body", with: @comment_body
      click_on "Create Comment"
    end
  end
end