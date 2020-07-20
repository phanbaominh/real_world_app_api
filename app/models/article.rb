# typed: true
# frozen_string_literal: true

class Article < ApplicationRecord
  extend T::Sig
  extend FriendlyId

  belongs_to :author, class_name: 'User', inverse_of: :articles
  has_many :favorites, dependent: :nullify
  has_many :favored_users, through: :favorites, source: :user
  has_many :taggings, dependent: :nullify
  has_many :tags, through: :taggings
  has_many :comments, dependent: :nullify

  friendly_id :slug_candidates, use: :slugged

  validates :title, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
  validates :description, presence: true, allow_blank: false
  validates :slug, presence: true, allow_blank: false

  sig { returns(T::Array[T.untyped]) }
  def slug_candidates
    [
      :title,
      %i[title author_name]
    ]
  end

  sig { returns(String) }
  def author_name
    author.username
  end

  sig { params(User).returns(T::Boolean) }
  def favorited?(user)
    user.favorited_articles.include?(self)
  end

  sig { returns(Number) }
  def favorites_count
    favored_users.size
  end
end
