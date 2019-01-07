require 'rails_helper'

feature "user sign-up" do
  before :each do
    visit signup_path
  end

  context 'all fills are present' do
    it 'shows first name field' do
      expect(page).to have_selector("input[name='user[profile][first_name]']")
    end
    it 'shows last name field' do
      expect(page).to have_selector("input[name='user[profile][last_name]']")
    end
    it 'shows birthday select box for year' do
      expect(page).to have_select('user[profile][birthday(1i)]')
    end
    it 'shows birthday select box for month' do
      expect(page).to have_select('user[profile][birthday(2i)]')
    end
    it 'shows birthday select box for date' do
      expect(page).to have_select('user[profile][birthday(3i)]')
    end

    it 'shows two radio buttons' do
      expect(page).to have_selector("input[type='radio']", count: 2)
    end
    it 'shows label for female' do
      expect(page).to have_selector("label",text: 'female')
    end
    it 'shows label for male' do
      expect(page).to have_selector("label",text: 'male')
    end
    it 'shows email field' do
      expect(page).to have_selector("input[name='user[email]']", count: 1)
    end
    it 'shows password field' do
      expect(page).to have_selector("input[name='user[password]']", count: 1)
    end
    it 'shows password confirmation field' do
      expect(page).to have_selector("input[name='user[password_confirmation]']")
    end
    it 'shows signup button' do
      expect(page).to have_selector(:link_or_button, 'Sign up')
    end
    it 'shows login button' do
      expect(page).to have_selector(:link_or_button, 'Log in', count: 1)
    end
  end
end