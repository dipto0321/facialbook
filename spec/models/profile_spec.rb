require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'factories' do
    it "has a valid factory" do
      user = create(:user)
      expect(build(:profile, user_id: user.id)).to be_valid
    end

    it "has an invalid factory" do
      user = create(:user)
      expect(build(:invalid_profile, user_id:user.id)).to_not be_valid
    end
  end

end
