# typed: false
# frozen_string_literal: true

require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  USER_CONFIG = {
    email: 'test@mail.com', password: 'gamegame', username: 'tester'
  }.freeze

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

  def user_from_response
    body = JSON.parse(@response.body)
    body['user'] || body
  end

  def assert_user(received_user)
    assert_equal(@user.email, received_user['email'])
    assert_equal(@user.username, received_user['username'])
    assert_equal(@token, received_user['token'])
  end

  def tes_register_user
    user = USER_CONFIG
    post user_registration_path, params: { user: user }
    assert_response :success
    received_user = user_from_response
    assert_equal(user[:email], received_user['email'])
    assert_equal(user[:username], received_user['username'])
    assert_nil(received_user['image'])
    assert_nil(received_user['bio'])
  end

  def test_login_user
    assert_create_and_login_user
    received_user = user_from_response
    assert_user(received_user)
  end

  def test_get_user
    assert_create_and_login_user
    get user_path, headers: authorization_header
    assert_response :success
    assert_user(user_from_response)
  end

  def test_update_user
    assert_create_and_login_user
    put user_path, params: { user: { email: 'newemail@new.com' } }, headers: authorization_header
    assert_response :success
    received_user = user_from_response
    assert_equal('newemail@new.com', received_user['email'])
  end
end
