# frozen_string_literal: true

require 'rails_helper'

feature 'liking and unliking' do
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

  context 'Liking and unliking a post' do
    before :each do
      within "div#post-interaction-btns-#{@post.id}" do
        click_on 'Like'
      end
    end

    it 'likes the post' do
      expect(page).to have_selector(:link_or_button, @post.likes.count.to_s)
    end

    it 'unlikes a post' do
      click_on 'Unlike'
      expect(page).to have_selector(:link_or_button, 'Like', count: 2)
    end
  end

  context 'Liking a comment' do
    before :each do
      within 'div.comment-bg' do
        click_on 'Like'
      end
    end

    it 'likes the post' do
      expect(page).to have_selector(:link_or_button, @comment.likes.count.to_s)
    end

    it 'unlikes a comment' do
      click_on 'Unlike'
      expect(page).to have_selector(:link_or_button, 'Like', count: 2)
    end
  end
end
