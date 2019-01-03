require 'rails_helper'

feature 'clicking Add Friend button' do
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

    click_on("Add Friend")
  end

  it "adds to the database" do
    expect(@user.requestees).to include(@friend)
  end

  it "changes the Add Friend button into Request Sent button" do
    expect(page).to have_selector(:link_or_button, "Request Sent")
  end
end

feature "checking one's pending requests" do
  before(:each) do
    @user = create(:user)
    @friend = create(:user)

    # First log in
    visit new_user_session_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_on("Log in")

    visit user_path(@friend)

    click_on("Add Friend")

    visit root_path
    click_on("Sign Out")
    click_on("Sign in")
    fill_in "Email", with: @friend.email
    fill_in "Password", with: "password"
    click_on("Log in")
  end

  it 'works' do
    save_and_open_page
  end
end