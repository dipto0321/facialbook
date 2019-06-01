# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { create(:user) }
  let(:friend) { create(:user) }

  before do
    @request = create(:friend_request, requester_id: user.id, requestee_id: friend.id)
    @friendship = create(:friendship, user_id: user.id, friend_id: friend.id)
  end

  describe 'before_save callback' do
    it 'concatenates ids of user and friend before save' do
      expect(@friendship.concatenated).to eq([user.id, friend.id].sort.insert(1, 'X').join)
    end
  end

  describe 'after_save callback' do
    it 'deletes associated request' do
      expect(user.active_requests).to be_empty
      expect(friend.passive_requests).to be_empty
    end
  end

  describe '.find_friendship class method' do
    it 'returns friendship between 2 users' do
      expect(Friendship.between(user, friend)).to eq(@friendship)
    end
  end

  describe 'associations' do
    let(:friendship) { build(:friendship, user_id: user.id, friend_id: friend.id) }
    describe 'belongs_to user' do
      context 'user present' do
        it 'is valid' do
          expect(friendship).to be_valid
        end
      end

      context 'no user' do
        it 'is invalid' do
          friendship.user_id = nil
          expect(friendship).to_not be_valid
        end
      end
    end

    describe 'belongs_to friend' do
      context 'without friend' do
        it('is invalid') do
          friendship.friend_id = nil
          expect(friendship).to_not be_valid
        end
      end
    end
  end
end
