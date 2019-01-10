# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::AllFriendsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @current_user = create(:user)
      @friend = create(:user)
      sign_in(@current_user)
      get :index, params: { user_id: @friend.id }
    end

    it 'assigns to @user' do
      expect(assigns(:user)).to eq(@friend)
    end

    it 'assigns to @all_friends' do
      expect(assigns(:all_friends)).to eq(@friend.friends)
    end
  end
end