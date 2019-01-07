require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before :each do
      @user = create(:user)
      parameters = {params: {id: @user.id}}
      get :show, parameters
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'Assigns to @user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'Post #create' do
    it 'saves to the database' do
      expect{
        post :create, params: {
          user: {
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: Faker::Internet.email,
            password: 'password',
            password_confirmation: 'password',
            birthday: Faker::Date.birthday(18, 65),
            gender: 'male'
          }
        }
      }.to change(User, :count).by(1)
    end
  end

end
