# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  
  let(:user) { create(:user) }
  let(:friend) { create(:user) }
  let(:friendship) { create(:friendship, user_id: user.id, friend_id: friend.id) }
  
  context "before_save callback" do
    it "concatenates ids of user and friend before save" do
      expect(friendship.concatenated).to eq([user.id, friend.id].sort.join)
    end
  end

  context "find_friendship class method" do
    it "returns friendship between 2 users" do
      expect(Friendship.find_friendship(user, friend)).to eq(friendship)
    end
  end
end
