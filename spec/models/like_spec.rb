# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like do
  describe 'factories' do
    before :each do
      @user = create(:user)
      @liker = create(:user)
      @post = create(:user_post, postable_id: @user.id, author_id: @user.id)
    end
    it 'has a valid post_like factory' do
      expect(build(:post_like, liker_id: @liker.id, likeable_id: @post.id)).to be_valid
    end
    it 'has a valid comment_like factory' do
      comment = create(:post_comment, author_id: create(:user).id, commentable_id: @post.id)
      expect(build(:comment_like, liker_id: @liker.id, likeable_id: comment.id)).to be_valid
    end
  end
end
