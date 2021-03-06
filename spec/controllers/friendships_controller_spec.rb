# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendshipsController do
  describe '#Create' do
    it 'Saves to the database' do
      user = create(:user)
      friend = create(:user)
      friend_request = create(:friend_request, requester_id: user.id, requestee_id: friend.id)
      sign_in(friend)
      expect do
        post :create, params: {
          friendship: { user_id: user.id, friend_id: friend.id }
        }
      end.to change(Friendship, :count).by(1)
    end
    context 'instance variable assignments and redirection' do
      before(:each) do
        @friend = create(:user)
        @user = create(:user)
        @friend_request = create(:friend_request, requester_id: @user.id, requestee_id: @friend.id)

        parameters = { params: { friendship: attributes_for(:friendship, user_id: @user.id, friend_id: @friend.id) } }

        sign_in(@friend)
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

  describe '#destroy' do
    it 'removes the friendship from the database' do
      user = create(:user)
      friend = create(:user)
      sign_in(user)
      friendship = create(:friendship, user_id: user.id, friend_id: friend.id)
      expect do
        delete :destroy, params: {
          id: friendship.id
        }
      end.to change(Friendship, :count).by(-1)
    end

    context 'instance variables and redirection' do
      before :each do
        @user = create(:user)

        @friend = create(:user)

        @friendship = create(:friendship, user_id: @user.id, friend_id: @friend.id)

        parameters = { params: { id: @friendship.id } }

        sign_in(@user)

        delete :destroy, parameters
      end

      it 'assigns to @friendship' do
        expect(assigns(:friendship)).to eq(@friendship)
      end

      it 'redirects after successful delete' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
