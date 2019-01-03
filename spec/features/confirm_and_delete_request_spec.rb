require 'rails_helper'

feature "confirm and delete" do
  before :each do
    @requester = create(:user)
    @requestee = create(:user)
    
    # First log in
    visit new_user_session_path
    fill_in "Email", with: @requester.email
    fill_in "Password", with: "password"
    click_on("Log in")

    visit user_path(@requestee)
    click_on("Add Friend")
    visit root_path
    click_on("Sign Out")
    click_on("Sign in")

    fill_in "Email", with: @requestee.email
    fill_in "Password", with: "password"
    click_on("Log in")
  end

  context "requestee confirms friend request" do
    before :each do
      click_on("Confirm")
    end
    
    it "doesn't show the friend request anymore" do
      expect(page).to_not have_selector(:link_or_button, "Confirm")
    end
    
    it "adds the new friend to requestee's friend list" do
      visit user_path(@requestee)
      expect(page).to have_selector(:link_or_button, @requester.email)
    end
  end

  context "requestee deletes friend request" do
    before :each do
      click_on("Delete")
    end

    it "should not show the Delete button anymore" do
      expect(page).to_not have_selector(:link_or_button, "Delete")
    end

    it "doesn't add the requester to the requestee's friend list" do
      visit user_path(@requestee)
      expect(page).to_not have_selector(:link_or_button, @requester.email)
    end
  end

end