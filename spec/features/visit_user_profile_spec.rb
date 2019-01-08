require 'rails_helper'

feature "visiting user's profile" do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)
    @friend2 = create(:user)
    
    # First log in
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_on("Log in")
 
    create(:friendship, user_id: @friend.id, friend_id: @friend2.id)
 
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
  
end