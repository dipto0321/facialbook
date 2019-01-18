# frozen_string_literal: true

require 'rails_helper'

feature 'create new comment on post' do
  before :each do
    visit root_path
    @current_user = create(:user)
    @friend = create(:user)
    create(:friendship, friend_id: @friend.id, user_id: @current_user.id)
    @post = create(:user_post, author_id: @current_user.id, postable_id: @current_user.id)
    within '#navbarSupportedContent' do
      fill_in 'Email', with: @current_user.email
      fill_in 'Password', with: @current_user.password
      click_on 'Log in'
    end
  end

  context 'posting from home page' do
    before :each do
      @comment_body = Faker::Lorem.paragraph(2)
      fill_in 'comment_body', with: @comment_body
      click_on 'Comment'
    end

    it 'shows the comment created in the post' do
      expect(page).to have_content(@comment_body)
    end
  end

  context 'posting from user page' do
    before :each do
      visit user_path(@friend)
      @comment_body = Faker::Lorem.paragraph(2)
      fill_in 'comment_body', with: @comment_body
      click_on 'Comment'
    end
  end
end

feature "editing a comment" do
  before :each do
    @current_user = create(:user)
    @commenter = create(:user)
    @user_post = create(:user_post, author_id: @current_user.id, postable_id: @current_user.id)
    visit login_path
    @comment = create(:post_comment, author_id: @commenter.id, commentable_id: @user_post.id)
    @reply = create(:comment_reply, author_id: @commenter.id, commentable_id: @comment.id)

    fill_in "Email", with: @commenter.email
    fill_in "Password", with: @commenter.password
    click_on "Log in"
    visit user_path(@current_user)
    all(:link, "Edit")[1].click
  end

  context "editing a post comment" do
    it "opens edit path" do
      expect(page).to have_selector("textarea")
    end
  end

  scenario "editing a reply to a comment" do
  end
end
