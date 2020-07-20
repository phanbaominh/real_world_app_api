# typed: false
# frozen_string_literal: true

require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  def assert_profile(received_profile)
    user = users(:minh)
    assert_equal(user.username, received_profile['username'])
    assert_equal(user.bio, received_profile['bio'])
    assert_equal(user.image, received_profile['image'])
  end

  def profile_from_response
    JSON.parse(@response.body)['profile']
  end

  test 'get non existant profile' do
    get profile_path(:cool)
    assert_response :not_found
  end

  test 'get profile' do
    @user = User.new(USER_CONFIG)
    @user.save
    get profile_path(users(:minh).username)
    assert_response :success
    received_profile = profile_from_response
    assert_profile(received_profile)
  end

  test 'follow user' do
    assert_create_and_login_user
    post follow_path(users(:minh).username), headers: authorization_header
    assert_response :success
    received_profile = profile_from_response
    assert_profile(received_profile)
    assert(received_profile['following'])

    delete follow_path(users(:minh).username), headers: authorization_header
    assert_response :success
    received_profile = profile_from_response
    assert_not(received_profile['following'])
  end
end
