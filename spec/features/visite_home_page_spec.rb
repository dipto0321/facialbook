require "rails_helper"

feature 'visit home page without login' do
  before(:each) do
    visit root_path
  end
end

feature 'visit home page with login' do

end