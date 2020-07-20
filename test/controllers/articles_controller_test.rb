# typed: false
# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  RUDY_PASSWORD = 'human'
  def article_from_response
    Article.friendly.find(JSON.parse(@response.body)['article']['slug'])
  end

  test 'get not exist article' do
    get article_path(:cool)
    assert_response :not_found
  end

  test 'get article' do
    get article_path(articles(:rudy_article))
    assert_response :success
    assert articles(:rudy_article) == article_from_response
  end

  test 'get articles' do
  end

  test 'get feed' do
  end

  test 'create article' do
    login_with_user(users(:rudy), RUDY_PASSWORD)
    article = { title: 'test', body: 'test', description: 'test' }
    post articles_path, params: { article: article }, headers: authorization_header
    assert_response :success
    assert(article = Article.find_by(title: article[:title]))
    assert users(:rudy).articles.include?(article)
  end

  test 'delete article' do
    login_with_user(users(:rudy), RUDY_PASSWORD)
    assert Article.find(articles(:rudy_article).id)
    delete article_path(articles(:rudy_article)), headers: authorization_header
    assert_response :success
    assert_not Article.find_by(id: articles(:rudy_article).id)
  end

  test 'update article' do
    login_with_user(users(:rudy), RUDY_PASSWORD)
    new_title = 'Orsted is best'
    put article_path(articles(:rudy_article)), headers: authorization_header,
                                               params: { article: { title: new_title } }
    assert_response :success
    assert_equal(new_title, articles(:rudy_article).reload.title)
  end
end
