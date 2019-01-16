# frozen_string_literal: true

require 'rails_helper'

feature 'Create a new post' do
  context 'posting from home page' do
    before(:each) do
      @user = create(:user)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      @body = Faker::Lorem.paragraph(5)
      within '#postFormModal' do
        fill_in 'Create post', with: @body
        click_on('Share')
      end
    end

    it 'should create a post' do
      expect(page).to have_content(@body)
    end

    it 'should show a success flash message' do
      expect(page).to have_selector('div.alert.alert-success', text: 'Post created!')
    end

    it 'redirects back to home' do
      expect(page).to have_selector("textarea[name='post[body]']", text: '')
    end

    it 'shows Edit button' do
      expect(page).to have_selector(:link_or_button, 'Edit')
    end

    it 'shows Delete button' do
      expect(page).to have_selector(:link_or_button, 'Delete')
    end
  end

  context "posting from current user's own timeline" do
    before(:each) do
      @current_user = create(:user)
      # First log in
      visit login_path
      fill_in 'Email', with: @current_user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@current_user)
      @another_body = Faker::Lorem.paragraph(5)
      within '#postFormModal' do
        fill_in 'Create post', with: @another_body
        click_on('Share')
      end
    end

    it 'creates the post' do
      expect(page).to have_content(@another_body)
    end

    it 'shows flash message' do
      expect(page).to have_selector('div.alert.alert-success', text: 'Post created!')
    end

    it "shows the user's info box" do
      within 'div#profile-card' do
        expect(page).to have_selector('h1', text: @current_user.profile.full_name)
      end
    end

    it 'shows Edit button' do
      expect(page).to have_selector(:link_or_button, 'Edit')
    end

    it 'shows Delete button' do
      expect(page).to have_selector(:link_or_button, 'Delete')
    end
  end

  context "posting on a friend's timeline" do
    before(:each) do
      @current_user = create(:user)
      @friend = create(:user)
      # First log in
      visit login_path
      fill_in 'Email', with: @current_user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@friend)
      @greeting = Faker::Lorem.paragraph(5)
      within '#postFormModal' do
        fill_in 'Create post', with: @greeting
        click_on('Share')
      end
    end

    it "allows the user to post in his/her friend's timeline" do
      expect(page).to have_content(@greeting)
    end

    it "shows the friend's info box" do
      within 'div#profile-card' do
        expect(page).to have_selector('h1', text: @friend.profile.full_name)
      end
    end

    it 'shows flash message' do
      expect(page).to have_selector('div.alert.alert-success', text: 'Post created!')
    end

    it 'shows Edit button' do
      expect(page).to have_selector(:link_or_button, 'Edit')
    end

    it 'shows Delete button' do
      expect(page).to have_selector(:link_or_button, 'Delete')
    end
  end
end

feature 'Edit post' do
  context 'visiting edit post' do
    before(:each) do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      click_on('Edit')
    end

    it 'has a cancel button that redirects back to ' do
      expect(page).to have_link('Cancel', href: root_url)
    end

    it 'has a delete button' do
      expect(page).to have_link('Delete', href: post_path(@post))
    end
  end

  context 'updating post in newsfeed' do
    before(:each) do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      click_on('Edit')
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on('Share')
    end

    it "changes the post's content" do
      expect(page).to have_content(@body)
    end
  end

  context 'updating post in own timeline' do
    before :each do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@user)
      click_on('Edit')
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on('Share')
    end

    it "should change the post's content" do
      expect(page).to have_content(@body)
    end
  end

  context "updating post in friend's timeline" do
    before :each do
      @user = create(:user)
      @friend = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @friend.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@friend)
      click_on('Edit')
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on('Share')
    end

    it "should change the post's content" do
      expect(page).to have_content(@body)
    end
  end
end

feature 'Deleting post' do
  context 'deleting a post from newsfeed' do
    before :each do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit root_path
      click_on('Delete')
    end

    it 'removes the post from the newsfeed' do
      expect(page).to_not have_content(@post)
    end
  end
  context 'deleting a post from own timeline' do
    before :each do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@user)
      click_on('Delete')
    end

    it 'removes the post from the timeline' do
      expect(page).to_not have_content(@post)
    end
    it "shows the friend's info box" do
      within 'div#profile-card' do
        expect(page).to have_selector('h1', text: @user.profile.full_name)
      end
    end

    it 'shows flash message' do
      expect(page).to have_selector('div.alert.alert-info', text: 'Post deleted')
    end
  end
  context "deleting a post from friend's timeline" do
    before :each do
      @user = create(:user)
      @friend = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @friend.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@friend)
      click_on('Delete')
    end
    it 'removes the post from the friend timeline' do
      expect(page).to_not have_content(@post)
    end
    it "shows the friend's info box" do
      within 'div#profile-card' do
        expect(page).to have_selector('h1', text: @friend.profile.full_name)
      end
    end

    it 'shows flash message' do
      expect(page).to have_selector('div.alert.alert-info', text: 'Post deleted')
    end
  end
end
