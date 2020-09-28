# typed: strict
# frozen_string_literal: true

class Tag < ApplicationRecord
  default_scope -> { order created_at: :desc }
  has_many :taggings, dependent: :nullify
  has_many :articles, through: :taggings
end
