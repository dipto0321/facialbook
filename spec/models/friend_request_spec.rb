# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequest do
  describe 'factories' do
    it 'has a valid factory' do
      requester = create(:user)
      requestee = create(:user, email: 'requestee@gmail.com')
      expect(build(:friend_request, requester_id: requester.id, requestee_id: requestee.id)).to be_valid
    end
  end
end
