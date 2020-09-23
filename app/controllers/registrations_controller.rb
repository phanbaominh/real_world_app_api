# typed: false
# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  # rubocop:disable Metrics/MethodLength
  def create
    build_resource(sign_up_params)
    unless resource.save
      render json: { errors: resource.errors }, status: :unprocessable_entity
      return
    end
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        render 'users/show', locals: { user: resource }, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        render 'users/show', locals: { user: resource }, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render 'users/show', locals: { user: resource }
    end
  end
  # rubocop:enable Metrics/MethodLength
end
