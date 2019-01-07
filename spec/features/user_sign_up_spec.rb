require 'rails_helper'

feature "user sign-up" do
  before :each do
    visit signup_path
  end

  context 'all fills are present' do
    it 'shows first name field' do
      expect(page).to have_content('First name')
    end
    it 'shows last name field' do
      expect(page).to have_content('Last name')
    end
    it 'shows birthday select box' do
      expect(page).to have_select('birthday')
    end
  end
end