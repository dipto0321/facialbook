require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'factories' do
    it 'should have a valid factories' do
      expect(FactoryBot.build(:friendship)).to be_valid
    end
  end
end
