# frozen_string_literal: true

class Comments::LikesController < LikesController
  before_action :set_likeable

  private

  def set_likeable
    @likeable = Comment.find_by(id: params[:comment_id])
  end
end
