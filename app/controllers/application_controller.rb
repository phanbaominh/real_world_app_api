# typed: false
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # All requests are authenticated using JWT tokens so just need to clear out session
  # instead of throwing exception when no CSRF token is detected
  protect_from_forgery with: :null_session

  # Set default response to json
  respond_to :json
  before_action :underscore_params!

  private

  # transform all param key to underscore for easier handling
  # due to API spec requiring json request's key be in camelCase
  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
