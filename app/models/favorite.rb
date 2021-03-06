# typed: strict
# frozen_string_literal: true

class Favorite < ApplicationRecord
  validates :user_id, uniqueness: { scope: :article_id }
  belongs_to :user, inverse_of: :favorites
  belongs_to :article, inverse_of: :favorites
end
