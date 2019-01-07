# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'should have a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it "should build a profile after building the user" do
      user = build(:user)
      expect(user.profile).to_not eq(nil)
    end

    it 'should have a invalid factory' do
      expect(FactoryBot.build(:invalid_user)).not_to be_valid
    end
  end

  describe 'Friendship Association' do
    it { should have_many(:active_friendships).with_foreign_key('user_id').class_name('Friendship') }

    it { should have_many(:passive_friendships).with_foreign_key('friend_id').class_name('Friendship') }

    it { should have_many(:added_friends).through(:active_friendships) }

    it { should have_many(:adding_friends).through(:passive_friendships) }
  end

  describe "FriendRequest Association" do
    it {should have_many(:active_requests).with_foreign_key("requester_id").class_name("FriendRequest")}

    it {should have_many(:passive_requests).with_foreign_key("requestee_id").class_name("FriendRequest")}

    it {should have_many(:requestees).through(:active_requests)}

    it {should have_many(:requesters).through(:passive_requests)}
  end

  describe "Profile association" do
    it { should have_one(:profile) }
    it{ should accept_nested_attributes_for(:profile) }
  end
end
