# typed: strict
# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :tag, inverse_of: :taggings
  belongs_to :article, inverse_of: :taggings
end
