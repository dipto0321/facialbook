require 'rails_helper'

feature "liking" do
  before :each do
    @user = create(:user)
    @liker = create(:user)
    @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
    @comment = create(:post_comment, commentable_id: @post.id, author_id: @user.id)
    visit login_path
    fill_in 'Email', with: @liker.email
    fill_in 'Password', with: @liker.password
    click_on('Log in')
    visit user_path(@user)
  end

  context "Liking post" do
    it "likes the post" do
      within "div#post-interaction-btns" do
        click_on "LIKE"
      end
      expect(page).to have_selector(:link_or_button, "#{@post.likes.count} like")
    end
  end

  context "Liking a comment" do
    it "likes the post" do
      within "div.comment-bg" do
        click_on "Like"
      end
      expect(page).to have_selector(:link_or_button, "#{@comment.likes.count} like")
    end
  end

end