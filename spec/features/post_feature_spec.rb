require 'rails_helper'


feature 'Create a new post' do
  before(:each) do
    @user = create(:user)

    # First log in
    visit new_user_session_path
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
end