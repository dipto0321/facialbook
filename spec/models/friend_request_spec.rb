# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequest do
  before do
    @adam = create(:user)
    @bert = create(:user)
  end

  describe "before_validation callback" do
    context "requests between non-friends" do
      it "is valid" do
        expect(@adam.active_requests.build(requestee_id: @bert.id)).to be_valid

        expect(@bert.active_requests.build(requestee_id: @adam.id)).to be_valid
      end
    end

    context "requests between friends" do
      it "is invalid" do
        create(:friendship, user_id: @adam.id, friend_id: @bert.id)

        expect(@bert.active_requests.build(requestee_id: @adam.id)).to_not be_valid

        expect(@bert.active_requests.build(requestee_id: @adam.id)).to_not be_valid
      end
    end
  end

  describe "before_save callback" do
    context "no requests between Adam and Bert" do
      let(:request) { create(:friend_request, requester_id: @adam.id, requestee_id: @bert.id)}
      it "creates a new string w/ an 'X' in the middle of their ids" do
        expect(request.concatenated).to match("#{@adam.id}X#{@bert.id}")
      end
    end

    context "request already existing between Adam and Bert" do
      it "doesn't allow another request from either Adam or Bert" do
        create(:friendship, user_id: @adam.id, friend_id: @bert.id)
        request1 = build(:friend_request, requester_id: @bert.id, requestee_id: @adam.id)
        request2 = build(:friend_request, requester_id: @adam.id, requestee_id: @bert.id)
        expect(request1).to_not be_valid
      end
    end
  end

  describe "associations" do
    context "valid friend requests" do
      let(:request) { build(:friend_request, requester_id: @adam.id, requestee_id: @bert.id) }

      it "is valid with requester and requestee" do
        expect(request).to be_valid
      end
    end

    context "without requester or requestee" do
      let(:request1) { build(:friend_request, requestee_id: nil) }
      let(:request2) { build(:friend_request, requester_id: nil) }

      it "raises an error when validating" do
        expect{ request1.valid? }.to raise_error(NoMethodError)
        expect{ request2.valid? }.to raise_error(NoMethodError)
      end
    end
  end
end
