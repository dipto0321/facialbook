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
end
