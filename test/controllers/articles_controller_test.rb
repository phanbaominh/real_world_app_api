# typed: false
# frozen_string_literal: true

require 'test_helper'

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def article_from_response
    Article.friendly.find(JSON.parse(@response.body)['article']['slug'])
  end

  def assert_articles(received_articles, expected_articles, user = nil)
    received_articles.each do |article|
      assert expected_articles.include?(Article.friendly.find(article['slug']))
      if user
        author = User.find_by(username: article['author']['username'])
        assert article['author']['following'] if user.followings.include?(author)
      end
    end
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

  test 'get queried articles by tag and author' do
    get articles_path, params: { tag: 'magic', author: users(:roxy).username }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 1, response['articlesCount']
    assert_equal articles(:roxy_article), Article.friendly.find(response['articles'][0]['slug'])
  end

  test 'get queried articles by tag and favorites' do
    get articles_path, params: { tag: 'knowledge', favorited: users(:rudy).username }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal 1, response['articlesCount']
    assert_equal articles(:eris_article), Article.friendly.find(response['articles'][0]['slug'])
  end

  test 'get articles without authorization' do
    get articles_path
    assert_response :success
    response = JSON.parse(@response.body)
    assert_articles(response['articles'], articles)
    assert_equal(articles.size, response['articlesCount'])
  end

  test 'get articles with authorization' do
    login_rudy
    get articles_path, headers: authorization_header
    assert_response :success
    response = JSON.parse(@response.body)
    assert_articles(response['articles'], articles, users(:rudy))
    assert_equal(articles.size, response['articlesCount'])
  end

  test 'get feed' do
    login_rudy
    get feed_articles_path, headers: authorization_header
    assert_response :success
    response = JSON.parse(@response.body)
    followings_articles = users(:rudy).followed_articles
    assert_articles(response['articles'], followings_articles)
    assert_equal(followings_articles.size, response['articlesCount'])
  end

  test 'create article' do
    login_rudy
    article = { title: 'test', body: 'test', description: 'test' }
    post articles_path, params: { article: article }, headers: authorization_header
    assert_response :success
    assert(article = Article.find_by(title: article[:title]))
    assert users(:rudy).articles.include?(article)
  end

  test 'delete article' do
    login_rudy
    assert Article.find(articles(:rudy_article).id)
    delete article_path(articles(:rudy_article)), headers: authorization_header
    assert_response :success
    assert_not Article.find_by(id: articles(:rudy_article).id)
  end

  test 'update article' do
    login_rudy
    new_title = 'Orsted is best'
    put article_path(articles(:rudy_article)), headers: authorization_header,
                                               params: { article: { title: new_title } }
    assert_response :success
    assert_equal(new_title, articles(:rudy_article).reload.title)
  end
end
