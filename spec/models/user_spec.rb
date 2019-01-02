require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'should have a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end

    it 'should have a invalid factory' do
      expect(FactoryBot.build(:invalid_user)).not_to be_valid
    end
  end

  describe 'Association' do
    it { should have_many(:active_friendships).with_foreign_key('user_id').class_name('Friendship') }

    it { should have_many(:passive_friendships).with_foreign_key('friend_id').class_name('Friendship') }

    it { should have_many(:added_friends).through(:active_friendships) }

    it { should have_many(:adding_friends).through(:passive_friendships) }
  end
end
