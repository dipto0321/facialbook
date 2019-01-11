# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'should have a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'should build a profile after building the user' do
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

    it { should have_many(:added_friends).through(:active_friendships).source(:friend) }

    it { should have_many(:adding_friends).through(:passive_friendships).source(:user) }
  end

  describe 'FriendRequest Association' do
    it { should have_many(:active_requests).with_foreign_key('requester_id').class_name('FriendRequest') }

    it { should have_many(:passive_requests).with_foreign_key('requestee_id').class_name('FriendRequest') }

    it { should have_many(:requestees).through(:active_requests) }

    it { should have_many(:requesters).through(:passive_requests) }
  end

  describe 'Profile association' do
    it { should have_one(:profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:profile).allow_destroy(true) }
  end


  describe 'Post association' do
    # it { should have_many(:posts).with_foreign_key(:author_id).dependent(:destroy) }
    before :each do
      @author = create(:user)
      @postable = create(:user)
      @post = create(:user_post, author_id: @author.id, postable_id: @postable.id)
    end
    it "associates a postable user to the post" do
    expect(@postable.posts.last).to eq(@post)
    end

    it "associates the post's author to the user that created it" do
      expect(@post.author).to eq(@author)
    end
  end
end
