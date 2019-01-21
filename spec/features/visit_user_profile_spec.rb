# frozen_string_literal: true

require 'rails_helper'

feature "visiting user's profile" do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)
    @friend2 = create(:user)

    # First log in
    visit login_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on('Log in')

    create(:friendship, user_id: @friend.id, friend_id: @friend2.id)

    @post_by_user_to_friend = create(:user_post, author_id: @user.id, postable_id: @friend.id)

    @share_by_friend = create(:user_post, author_id: @friend.id, postable_id: @friend.id)

    @post_by_friend_to_friend2 = create(:user_post, author_id: @friend.id, postable_id: @friend2.id)

    @post_like = create(:post_like, likeable_id: @share_by_friend.id, liker_id: @user.id)

    @post_comment = create(:post_comment, commentable_id: @post_by_user_to_friend.id, author_id: @user.id)

    @comment_like = create(:comment_like, likeable_id: @post_comment.id, liker_id: @friend.id)

    visit user_path(@friend)
  end

  it "shows friend's email" do
    expect(page).to have_content(@friend.profile.full_name)
  end
  it 'shows add friend button' do
    expect(page).to have_selector(:link_or_button, 'Add Friend')
  end

  it 'shows all friends of user' do
    within('ul#partial-friends-list') do
      expect(page).to have_selector(:link_or_button, @friend2.profile.full_name)
    end
  end

  it 'shows a create post form' do
    expect(page).to have_selector("textarea[name='post[body]']")
  end

  it 'shows a share button' do
    expect(page).to have_selector(:link_or_button, 'Share')
  end

  it 'shows all the posts that user has created' do
    expect(page).to have_content(@share_by_friend.body)
  end

  it 'shows all posts that the user received from other users' do
    expect(page).to have_content(@post_by_user_to_friend.body)
  end

  it "shows all posts that the user made on other user's timeline" do
    expect(page).to have_content(@post_by_friend_to_friend2.body)
  end

  it 'shows likes by @friend_who_posted on @post_by_current_user' do
    expect(page).to have_selector(:link_or_button,  "#{@share_by_friend.likes.count} like")
  end

  it 'shows likes on comments' do
    expect(page).to have_selector(:link_or_button,  "#{@post_comment.likes.count} like")
  end
end
