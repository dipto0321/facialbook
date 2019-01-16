
require 'rails_helper'

feature "show comments in post" do
  before :each do
    @current_user = create(:user)
    @commenter1 = create(:user)
    @commenter2 = create(:user)
    @post = create(:user_post, postable_id: @current_user.id, author_id: @current_user.id)
    @comment1 = create(:post_comment, commenter_id: @commenter1.id, commentable_id: @post.id)

    visit login_path
    fill_in "Email", with: @current_user.email
    fill_in "Password", with: @current_user.password
    click_on "Log in"
  end

  it "shows the commenter's full name" do
    expect(page).to have_selector(:link_or_button, @commenter1.profile.full_name)
  end

  it "shows the comment body" do
    expect(page).to have_content(@comment1.body)
  end
end