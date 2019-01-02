require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'factories' do
    it 'should have a valid factories' do
      
      user = FactoryBot.create(:user, email:"user@gmail.com")
      friend = FactoryBot.create(:user, email:"friend@gmail.com")

      expect(FactoryBot.build(:friendship, user_id: user.id, friend_id: friend.id)).to be_valid
    end
  end
end
