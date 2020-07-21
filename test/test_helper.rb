# typed: false
# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  extend T::Sig
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  USER_CONFIG = {
    email: 'test@mail.com', password: 'gamegame', username: 'tester'
  }.freeze

  RUDY_PASSWORD = 'human'

  def login_with_user(user, password)
    post new_user_session_path, params: { user: { email: user.email, password: password } }
    @token = user_from_response['token']
  end

  def login_rudy
    login_with_user(users(:rudy), RUDY_PASSWORD)
  end

  def user_from_response
    body = JSON.parse(@response.body)
    body['user'] || body
  end

  def assert_create_and_login_user
    @user = User.new(USER_CONFIG)
    @user.save
    post new_user_session_path, params: { user: { email: @user.email, password: @user.password } }
    assert_response :success, 'login successful'
    @token = user_from_response['token']
    assert_not_nil @token, 'token exist'
  end

  def authorization_header
    { 'Authorization' => "Token token=#{@token}" }
  end

  def assert_followings(model_with_author, user)
    author = User.find_by(username: model_with_author['author']['username'])
    assert model_with_author['author']['following'] if user.followings.include?(author)
  end
  # Add more helper methods to be used by all tests here...
end
