require 'rails_helper'


feature 'Create a new post' do
  context "posting from home page" do
    before(:each) do
      @user = create(:user)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on("Share")
    end
  
    it 'should create a post' do
      expect(page).to have_content(@body)
    end
  
    it 'should show a success flash message' do
      expect(page).to have_selector("div.alert.alert-success", text:"Post created!")
    end
  
    it "redirects back to home" do
      expect(page).to have_selector("textarea[name='post[body]']", text: "")
    end

    it "shows Edit button" do
      expect(page).to have_selector(:link_or_button, "Edit")
    end

    it "shows Delete button" do
      expect(page).to have_selector(:link_or_button, "Delete")
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
      fill_in 'Create post', with: @another_body
      click_on("Share")
    end

    it "creates the post" do
      expect(page).to have_content(@another_body)
    end

    it "shows flash message" do
      expect(page).to have_selector("div.alert.alert-success", text:"Post created!")
    end

    it "shows the user's info box" do
      within "div#profile-card" do
        expect(page).to have_selector("h1", text: @current_user.profile.full_name)
      end
    end

    it "shows Edit button" do
      expect(page).to have_selector(:link_or_button, "Edit")
    end

    it "shows Delete button" do
      expect(page).to have_selector(:link_or_button, "Delete")
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
    fill_in 'Create post', with: @greeting
    click_on("Share")
    end

    it "allows the user to post in his/her friend's timeline" do
      expect(page).to have_content(@greeting)
    end

    it "shows the friend's info box" do
      within "div#profile-card" do
        expect(page).to have_selector("h1", text: @friend.profile.full_name)
      end
    end

    it "shows flash message" do
      expect(page).to have_selector("div.alert.alert-success", text:"Post created!")
    end

    it "shows Edit button" do
      expect(page).to have_selector(:link_or_button, "Edit")
    end

    it "shows Delete button" do
      expect(page).to have_selector(:link_or_button, "Delete")
    end

  end
end

feature "Edit post" do
  context "editing post in newsfeed" do
    before(:each) do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      click_on("Edit")
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on("Share")
    end

    it "should change the post's content" do
      expect(page).to have_content(@body)
    end
  end
  
  context "editing post in own timeline" do
    before :each do
      @user = create(:user)
      @post = create(:user_post, author_id: @user.id, postable_id: @user.id)
      # First log in
      visit login_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'password'
      click_on('Log in')
      visit user_path(@user)
      click_on("Edit")
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on("Share")
    end

    it "should change the post's content" do
      expect(page).to have_content(@body)
    end
  end

  context "editing post in friend's timeline" do
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
      click_on("Edit")
      @body = Faker::Lorem.paragraph(5)
      fill_in 'Create post', with: @body
      click_on("Share")
    end

    it "should change the post's content" do
      expect(page).to have_content(@body)
    end
  end
end