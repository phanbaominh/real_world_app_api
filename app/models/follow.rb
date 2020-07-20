# typed: strict
# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :following_follows
  belongs_to :following, class_name: 'User', inverse_of: :follower_follows
end
