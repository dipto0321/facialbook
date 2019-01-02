# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController do
  describe '#Create' do
    it 'Saves to the database' do
      user = create(:user)
      friend = create(:user)
      sign_in(user)
      expect {
        post :create, params: {
          friendship: { user_id: user.id, friend_id: friend.id }
        }
      }.to change(Friendship, :count).by(1)
    end
    context 'instance variable assignments and redirection' do
      before(:each) do
        @user = create(:user)
        @friend = create(:user, email: 'friend@gmail.com')

        parameters = { params: { friendship: attributes_for(:friendship, user_id: @user.id, friend_id: @friend.id) } }

        sign_in(@user)
        post :create, parameters
      end

      it 'Assigns to @user' do
        expect(assigns(:user)).to eq(@user)
      end

      it 'Assigns to @friend' do
        expect(assigns(:friend)).to eq(@friend)
      end

      it 'redirects' do
        expect(response).to redirect_to(user_path(@user))
      end
    end
  end
end
