# typed: false
# frozen_string_literal: true

require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  sig { void }
  def test_favorite_article
    login_rudy
    article = articles(:roxy_article)
    assert_not article.favored_users.include?(users(:rudy))
    post article_favorite_path(article), headers: authorization_header
    assert_response :success
    assert article.favored_users.include?(users(:rudy))
  end

  sig { void }
  def test_unfavorite_article
    login_rudy
    article = articles(:eris_article)
    assert article.favored_users.include?(users(:rudy))
    delete article_favorite_path(article), headers: authorization_header
    assert_response :success
    assert_not article.favored_users.include?(users(:rudy))
  end
end
