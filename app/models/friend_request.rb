# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: 'User'
  belongs_to :requestee, class_name: 'User'
  default_scope {eager_load(:requester).eager_load(:requestee)}

  def accept
    update_attributes(responded: true, accepted: true)
  end
end
