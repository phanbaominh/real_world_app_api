# typed: true
# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :articles
  has_many :favorites, dependent: :nullify
  has_many :favored_users, through: :favorites, source: :user
  has_many :taggings, dependent: :nullify
  has_many :tags, through: :taggings
  has_many :comments, dependent: :nullify
end
