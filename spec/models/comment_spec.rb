# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "Comment's associations" do
    it { should belong_to(:commentable) }
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
  end

  context 'Factories and instance method' do
    it 'has a valid factory' do
      user = create(:user)
      post = create(:user_post, postable_id: user.id, author_id: user.id)
      expect(build(:post_comment, commentable_id: post.id, author_id: user.id)).to be_valid
    end

    it 'has not a valid comment without body' do
      @user = create(:user)
      @post = create(:user_post, postable_id: @user.id, author_id: @user.id)
      @comment = build(:post_comment, commentable_id: @post.id, author_id: @user.id, body: nil)
      @comment.valid?
      expect(@comment.errors[:body]).to include("can't be blank")
    end
  end
end
