# typed: strict
# frozen_string_literal: true

SorbetRails.configure do |config|
  config.extra_helper_includes = ['ApplicationHelper', 'Devise::Controllers::Helpers']
end
