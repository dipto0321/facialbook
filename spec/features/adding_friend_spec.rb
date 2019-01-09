# frozen_string_literal: true

require 'rails_helper'

feature 'clicking Add Friend button' do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)
    @friend2 = create(:user)

    # First log in
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on('Log in')

    create(:friendship, user_id: @friend.id, friend_id: @friend2.id)

    visit user_path(@friend)

    click_on('Add Friend')
  end

  it 'adds to the database' do
    expect(@user.requestees).to include(@friend)
  end

  it 'changes the Add Friend button into Request Sent button' do
    expect(page).to have_selector(:link_or_button, 'Request sent')
  end

  it "doesn't show the Add Friend button if the current_user visits his/her own profile" do
    visit user_path(@user)
    expect(page).to_not have_selector(:link_or_button, 'Add Friend')
  end
end

feature "checking one's pending requests" do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)

    # First log in
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_on('Log in')

    visit user_path(@friend)

    click_on('Add Friend')

    click_on('Sign Out')
    click_on('Log in')
    fill_in 'Email', with: @friend.email
    fill_in 'Password', with: 'password'
    click_on('Log in')
  end

  it "shows a logged user's pending friend requests in the home page" do
    expect(page).to have_selector(:link_or_button, 'Confirm')
  end
end
