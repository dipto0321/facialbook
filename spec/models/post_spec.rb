require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'User and timeline associations' do
    it { should belong_to(:user) }
    it { should belong_to(:timeline) }
  end

  describe 'factories' do
    it 'has a valid factory' do
      user = create(:user)
      user.build_timeline.save
      timeline = Timeline.last
      expect(build(:timeline_post, user_id: user.id, timeline_id: timeline.id)).to be_valid
    end
  end
end
