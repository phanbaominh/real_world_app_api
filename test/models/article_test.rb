# typed: false
# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  extend T::Sig
  sig { void }
  def test_following_article
    following_articles = users(:rudy).followed_articles
    assert following_articles.include?(articles(:sylphy_article))
    assert following_articles.include?(articles(:roxy_article))
    assert_not following_articles.include?(articles(:rudy_article))
  end
end
