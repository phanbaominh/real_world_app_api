# typed: false
# frozen_string_literal: true

require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  extend T::Sig

  sig { void }
  def test_get_tags
    get tags_path
    assert_response :success
    received_tags = JSON.parse(@response.body)['tags']
    assert_equal tags.size, received_tags.size
    received_tags.each do |tag|
      assert Tag.find_by(name: tag)
    end
  end
end
