require 'rails_helper'

feature "visiting user's profile" do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)
    @friend2 = create(:user)
    create(:friendship, user_id: @friend.id, friend_id: @friend2.id)
    page.set_rack_session(user_id: @user.id)
    visit user_path(@friend)
  end

  it "shows friend's email" do
    expect(page).to have_content(@friend.email)
  end
  it 'shows add friend button' do
    expect(page).to have_selector(:link_or_button, 'Add Friend')
  end
  it 'shows all friends of user' do
    within('ul') do
      expect(page).to have_selector(:link_or_button, @friend2.email)
    end
    # save_and_open_page
  end
end