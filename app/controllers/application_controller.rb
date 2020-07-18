# typed: strict
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # All requests are authenticated using JWT tokens so just need to clear out session
  # instead of throwing exception when no CSRF token is detected
  protect_from_forgery with: :null_session
end
