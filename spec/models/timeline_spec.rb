require 'rails_helper'

RSpec.describe Timeline, type: :model do
  describe 'Owener and posts associations' do
    it { should belong_to(:owner).class_name('User') }
    it { should have_many(:posts) }
  end

  describe 'factories' do
    it "has a valid factory" do
      user = create(:user)
      expect(build(:timeline, owner_id: user.id)).to be_valid
    end
  end
end
