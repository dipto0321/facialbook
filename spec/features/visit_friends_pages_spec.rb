require 'rails_helper'

feature "visiting all_friends page" do

  context "unlogged user" do
    it "will redirect to login page" do
      user = create(:user)
      visit user_all_friends_path(user)
      expect(page).to have_selector("input[type='email']")
    end
  end

  context "logged user" do
    before :each do
      @user = create(:user)
      @visitor = create(:user)
      10.times do
        create(:user)
        create(:friendship, user_id: @user.id, friend_id: User.last.id)
      end

      create(:friendship, user_id: @visitor.id, friend_id: @user.friends.last.id)

      visit login_path
      fill_in "Email", with: @visitor.email
      fill_in "Password", with: "password"
      click_on("Log in")
      visit user_all_friends_path(@user)
    end

    it "should show all of the user's friends" do
      @user.friends.each do |friend|
        expect(page).to have_selector(:link_or_button, friend.profile.profile_picture.url)
      end
    end

    it "should show Add Friend button for user's friends who are not yet friends with visitor" do
      @user.friends.each do |friend|
        expect(page).to have_selector(:link_or_button, "Add friend") if !@visitor.friends.include?(friend)
      end
    end

    it "should show Friends button for user's friends who are also the visitor's friends" do
      @user.friends.each do |friend|
        expect(page).to have_selector(:link_or_button, "Unfriend") if @visitor.friends.include?(friend)
      end
    end

  end

end

feature "visiting mutual_friends page" do
  context "unlogged user" do
    it "will redirect to login page" do
      user = create(:user)
      visit user_mutual_friends_path(user)
      expect(page).to have_selector("input[type='email']")
    end
  end

  context "logged user" do
    before :each do
      @user = create(:user)
      @visitor = create(:user)
      10.times do
        create(:user)
        create(:friendship, user_id: @user.id, friend_id: User.last.id)
      end

      create(:friendship, user_id: @visitor.id, friend_id: @user.friends.last.id)

      visit login_path
      fill_in "Email", with: @visitor.email
      fill_in "Password", with: "password"
      click_on("Log in")
      visit user_mutual_friends_path(@user)
    end

    it "should show all of the user's friends" do
      @user.mutual_friends(@visitor).each do |friend|
        expect(page).to have_selector(:link_or_button, friend.profile.profile_picture.url)
      end
    end

    it "should show Add Friend button for user's friends who are not yet friends with visitor" do
      @user.mutual_friends(@visitor).each do |friend|
        expect(page).to have_selector(:link_or_button, "Add friend") if !@visitor.friends.include?(friend)
      end
    end

    it "should show Friends button for user's friends who are also the visitor's friends" do
      @user.mutual_friends(@visitor).each do |friend|
        expect(page).to have_selector(:link_or_button, "Unfriend") if @visitor.friends.include?(friend)
      end
    end

  end

end