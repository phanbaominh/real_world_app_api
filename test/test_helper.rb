# typed: false
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  USER_CONFIG = {
    email: 'test@mail.com', password: 'gamegame', username: 'tester'
  }.freeze

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
  # Add more helper methods to be used by all tests here...
end
