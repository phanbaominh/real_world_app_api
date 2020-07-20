# typed: strict
# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :nullify
  has_many :articles, through: :taggings
end
