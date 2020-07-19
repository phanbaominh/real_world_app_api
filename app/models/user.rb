# typed: true
# frozen_string_literal: true

class User < ApplicationRecord
  extend T::Sig
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false,
                       format: { with: /\A[a-zA-Z0-9_]+\z/ }
  has_many :follower_follows, class_name: 'Follow', foreign_key: 'following_id',
                              dependent: :nullify, inverse_of: :following
  has_many :following_follows, class_name: 'Follow', foreign_key: 'follower_id',
                               dependent: :nullify, inverse_of: :follower
  has_many :followers, through: :follower_follows, class_name: 'User'
  has_many :followings, through: :following_follows, class_name: 'User'

  has_many :articles, dependent: :nullify, foreign_key: 'author_id', inverse_of: :author
  has_many :favorites, dependent: :nullify
  has_many :favorited_articles, through: :favorites, source: :article
  has_many :comments, dependent: :nullify
  sig { returns(String) }
  def generate_jwt
    JWT.encode(
      {
        id: id,
        exp: 60.days.from_now.to_i
      },
      Rails.application.credentials[:secret_key_base]
    )
  end

  sig { params(user: User).returns(T::Boolean) }
  def followed?(user)
    followings.include?(user)
  end

  sig { params(user: User).void }
  def follow(user)
    followings << user
  end

  sig { params(user: User).void }
  def unfollow(user)
    followings.delete(user)
  end
end
