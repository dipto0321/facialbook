# frozen_string_literal: true

module CommentsHelper
  def action_type(commentable)
    commentable.class == Post ? 'Comment' : 'Reply'
  end
end
