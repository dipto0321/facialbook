# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation of user' do
    context 'complete signup details' do
      let(:user) { build(:user) }
      it 'is valid' do
        expect(FactoryBot.build(:user)).to be_valid
      end

      it 'has a user profile' do
        expect(user.profile).to_not eq(nil)
      end
    end

    context 'incomplete user details' do
      it 'is invalid' do
        expect(FactoryBot.build(:invalid_user)).not_to be_valid
      end
    end
  end

  context 'friendships' do
    it { should have_many(:active_friendships).with_foreign_key('user_id').class_name('Friendship') }
    it { should have_many(:passive_friendships).with_foreign_key('friend_id').class_name('Friendship') }
    it { should have_many(:added_friends).through(:active_friendships).source(:friend) }
    it { should have_many(:adding_friends).through(:passive_friendships).source(:user) }
  end

  context 'friend requests' do
    it { should have_many(:active_requests).with_foreign_key('requester_id').class_name('FriendRequest') }
    it { should have_many(:passive_requests).with_foreign_key('requestee_id').class_name('FriendRequest') }
    it { should have_many(:requestees).through(:active_requests) }
    it { should have_many(:requesters).through(:passive_requests) }
  end

  context 'profiles, posts, comments and likes' do
    it { should have_one(:profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:profile).allow_destroy(true) }
    it { should have_many(:authored_posts).with_foreign_key(:author_id).class_name('Post').dependent(:destroy) }
    it { should have_many(:received_posts).class_name('Post').dependent(:destroy) }
    it { should have_many(:comments).with_foreign_key(:author_id).dependent(:destroy) }
    it { should have_many(:likes).with_foreign_key(:liker_id).dependent(:destroy) }
  end

  context 'user not created without profile' do
    let(:user) { build(:user) }
    it 'is invalid' do
      user.profile = nil
      user.valid?
      expect(user.errors[:profile]).to include("can't be nil")
    end
  end

  describe 'delegations' do
    let(:george) { create(:user) }

    it 'returns full name for user' do
      expect(george.full_name).to eq(george.profile.full_name)
    end

    it 'returns birthday for user' do
      expect(george.birthday).to eq(george.profile.birthday)
    end
  end

  describe 'instance methods' do
    let(:john) { create(:user) }
    let(:mike) { create(:user) }
    let(:charles) { create(:user) }
    let(:rachel) { create(:user) }

    before do
      create(:friendship, user_id: john.id, friend_id: mike.id)
      create(:friendship, user_id: charles.id, friend_id: john.id)
      create(:friendship, user_id: rachel.id, friend_id: john.id)
    end

    describe 'friends' do
      it "lists a user's complete set of friends" do
        expect(john.friends.count).to be(3)
      end
    end

    describe 'mutual_friends' do
      it 'lists friends who are common between two users' do
        expect(rachel.mutual_friends(mike)).to include(john)
      end
    end

    describe 'friendships' do
      it "shows a user's current friendships" do
        expect(john.friendships.count).to be(3)
      end
    end

    describe 'has_pending_request_to? and has_pending_request_from?' do
      before do
        create(:friend_request, requester_id: rachel.id, requestee_id: charles.id)
      end

      context 'rachel has a pending request to charles' do
        it 'returns true' do
          expect(rachel.has_pending_request_to?(charles)).to be(true)
        end

        context 'charles has a pending request from rachel' do
          it 'returns true' do
            expect(charles.has_pending_request_from?(rachel)).to be(true)
          end
        end
      end
    end
  end
end
