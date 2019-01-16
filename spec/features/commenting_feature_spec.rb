require 'rails_helper'

feature "create new comment on post" do
  before :each do
    visit root_path
    @current_user = create(:user)
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
      within ("div.comment_body") do
        fill_in "comment_body", with: @comment_body
      end
    end

    it "should comment" do
      save_and_open_page
      # expect(page).to have_content(@comment_body)
    end

  end

  context "posting from user page" do
    before :each do
    end
  end

end