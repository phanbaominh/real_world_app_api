# typed: false
# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  sig do
    params(
      received_comments: T::Array[T::Hash[String, T.untyped]],
      expected_comments: ActiveRecord::Relation,
      user: T.nilable(User)
    ).void
  end
  def assert_comments(received_comments, expected_comments, user = nil)
    assert_equal expected_comments.size, received_comments.size
    received_comments.each do |comment|
      assert expected_comments.include?(Comment.find_by(id: comment['id']))
      assert_followings(comment, user) if user
    end
  end

  sig { void }
  def test_get_articles_with_auth
    login_rudy
    get article_comments_path(articles(:roxy_article)), headers: authorization_header
    assert_response :success
    assert_comments(
      JSON.parse(@response.body)['comments'],
      articles(:roxy_article).comments,
      users(:rudy)
    )
  end

  sig { void }
  def test_get_articles
    get article_comments_path(articles(:roxy_article))
    assert_response :success
    assert_comments(
      JSON.parse(@response.body)['comments'],
      articles(:roxy_article).comments,
    )
  end

  sig { void }
  def test_create_article
    login_rudy
    post article_comments_path(articles(:roxy_article)),
         headers: authorization_header,
         params: { comment: { body: 'Roxy number one!' } }
    assert_response :success
    received_comment_id = JSON.parse(@response.body)['comment']['id']
    assert articles(:roxy_article).comment?(received_comment_id)
  end

  sig { void }
  def test_destroy_article
    login_rudy
    comment_id = comments(:rudy_comment1).id
    assert articles(:roxy_article).comment?(comment_id)
    delete article_comment_path(articles(:roxy_article), comments(:rudy_comment1)),
           headers: authorization_header
    assert_response :success
    assert_not articles(:roxy_article).comment?(comment_id)
  end
end
