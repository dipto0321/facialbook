# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::MutualFriendsController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      user = create(:user)
      friend = create(:user)
      sign_in(user)
      get :index, params: {
        user_id: friend.id
      }
      expect(response).to have_http_status(:success)
    end

    context 'instance variable assignment and rendering' do
      before :each do
        @user = create(:user)
        @friend = create(:user)
        @mutual_friends = @user.mutual_friends(@friend)
        sign_in(@user)
        get :index, params: {
          user_id: @friend.id
        }
      end

      it 'assigns to @user' do
        expect(assigns(:user)).to eq(@friend)
      end

      it 'assigns to @mutual_friends' do
        expect(assigns(:mutual_friends)).to eq(@mutual_friends)
      end

      it 'renders index' do
        expect(response).to render_template('index')
      end
    end
  end
end
