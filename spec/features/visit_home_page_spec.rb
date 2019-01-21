# frozen_string_literal: true

require 'rails_helper'

feature 'visit home page without login' do
  before(:each) do
    visit root_path
  end

  it 'shows login button' do
    expect(page).to have_selector(:link_or_button, 'Log in')
  end

  it 'shows login button' do
    expect(page).to have_selector(:link_or_button, 'Sign up')
  end

  it 'shows 2 email input boxes (one for login and one for signup)' do
    expect(page).to have_selector("input[type='email']", count: 2)
  end

  it 'shows 2 password boxes (one for login and 2 for signup)' do
    expect(page).to have_selector("input[type='password']", count: 3)
  end

  it 'shows first name field' do
    expect(page).to have_selector("input[name='user[profile_attributes][first_name]']")
  end
  it 'shows last name field' do
    expect(page).to have_selector("input[name='user[profile_attributes][last_name]']")
  end
  it 'shows birthday select box for year' do
    expect(page).to have_select('user[profile_attributes][birthday(1i)]')
  end
  it 'shows birthday select box for month' do
    expect(page).to have_select('user[profile_attributes][birthday(2i)]')
  end
  it 'shows birthday select box for date' do
    expect(page).to have_select('user[profile_attributes][birthday(3i)]')
  end

  it 'shows two radio buttons' do
    expect(page).to have_selector("input[type='radio']", count: 2)
  end
  it 'shows label for female' do
    expect(page).to have_selector('label', text: 'Female')
  end
  it 'shows label for male' do
    expect(page).to have_selector('label', text: 'Male')
  end

  it 'shows a tagline' do
    expect(page).to have_selector('h3#tagline')
  end
end

feature 'visit home page with login' do
  before :each do
    @current_user = create(:user)
    @friend_posted_on = create(:user)
    @friend_who_posted = create(:user)

    @share = create(:user_post, author_id: @current_user.id, postable_id: @current_user.id)

    @post_on_current_user = create(:user_post, author_id: @friend_who_posted.id, postable_id: @current_user.id)

    @post_by_current_user_to_another = create(:user_post, author_id: @current_user.id, postable_id: @friend_posted_on.id)

    @post_like = create(:post_like, likeable_id: @post_on_current_user.id, liker_id: @friend_who_posted.id)

    @post_comment = create(:post_comment, commentable_id: @post_on_current_user.id, author_id: @current_user.id)

    @comment_like = create(:comment_like, likeable_id: @post_comment.id, liker_id: @friend_who_posted.id)

    visit root_path
    within 'div.nav-sign-in' do
      fill_in 'Email', with: @current_user.email

      fill_in 'Password', with: @current_user.password

      click_on('Log in')
    end
  end

  it 'shows a search box' do
    expect(page).to have_selector("input[type='search']")
  end

  it "shows a link to the current_user's page in the nav" do
    expect(page).to have_link(@current_user.profile.first_name, href: user_path(@current_user))
  end

  it 'shows 2 links to home page in the nav' do
    expect(page).to have_selector("a[href='/']", count: 2)
  end

  it 'shows a dropdown link for friend requests' do
    expect(page).to have_selector('li#friend_request')
  end

  it 'shows a dropdown for profile options in the nav' do
    expect(page).to have_selector('li#profile_options')
  end

  it 'shows a create post form' do
    expect(page).to have_selector("textarea[name='post[body]']")
  end

  it 'shows post shared by current_user in his/her own timeline' do
    expect(page).to have_content(@share.body)
  end

  it "shows posts by current_user's friend to current_user's timeline" do
    expect(page).to have_content(@post_on_current_user.body)
  end

  it "shows posts by current_user to his/her friends' timelines" do
    expect(page).to have_content(@post_by_current_user_to_another.body)
  end

  it 'shows likes by @friend_who_posted on @post_by_current_user' do
    expect(page).to have_selector(:link_or_button,  "#{@post_on_current_user.likes.count} like")
  end

  it 'shows likes on comments' do
    expect(page).to have_selector(:link_or_button,  "#{@post_comment.likes.count} like")
  end
end
