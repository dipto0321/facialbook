# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      sign_in(create(:user))
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before :each do
      @user = create(:user)
      parameters = { params: { id: @user.id } }
      sign_in(@user)
      get :show, parameters
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'Assigns to @user' do
      expect(assigns(:user)).to eq(@user)
    end

    it 'renders template' do
      expect(response).to render_template(:show)
    end
  end
end
