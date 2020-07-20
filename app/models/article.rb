# typed: true
# frozen_string_literal: true

class Article < ApplicationRecord
  extend T::Sig
  extend FriendlyId

  scope :tagged_with,
        ->(tag) { joins(:taggings).where(taggings: { tag: tag }) }
  scope :favorited_by,
        ->(user) { joins(:favorites).where(favorites: { user: user }) }
  scope :authored_by,
        ->(author) { where(author: author) }

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

  sig { params(user: T.nilable(User)).returns(T::Boolean) }
  def favorited?(user)
    return false unless user

    user.favorited_articles.include?(self)
  end

  sig { returns(Integer) }
  def favorites_count
    favored_users.size
  end

  sig { params(user: User).returns(T::Boolean) }
  def authored_by?(user)
    author == user
  end

  sig { returns(T::Boolean) }
  def should_generate_new_friendly_id?
    attribute_changed?(:title) || super
  end

  sig { params(tag_list: T.nilable(T::Array[String])).void }
  def add_tags!(tag_list)
    tag_list&.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      tags << tag
    end
  end
end
