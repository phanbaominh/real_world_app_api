# typed: true
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend T::Sig
  # All requests are authenticated using JWT tokens so just need to clear out session
  # instead of throwing exception when no CSRF token is detected
  protect_from_forgery with: :null_session

  # Set default response to json
  respond_to :json
  before_action :underscore_params!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user_with_jwt
  before_action :cors_set_controll_access_headers

  private

  def cors_set_controll_access_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
  # transform all param key to underscore for easier handling
  # due to API spec requiring json request's key be in camelCase
  sig { void }
  def underscore_params!
    params.transform_keys!(&:underscore)
  end

  sig { void }
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  sig { void }
  def authenticate_user_with_jwt
    return if request.headers['Authorization'].blank?

    authenticate_or_request_with_http_token do |token|
      payload = JWT.decode(token, Rails.application.credentials[:secret_key_base]).first
      @current_user_id = payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head :unauthorized
    end
  end

  sig { void }
  def authenticate_user!
    head :unauthorized unless signed_in?
  end

  sig { returns(User) }
  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  sig { returns(T.nilable(User)) }
  def current_user_or_nil
    @current_user_id ? current_user : nil
  end

  sig { returns(T::Boolean) }
  def signed_in?
    @current_user_id.present?
  end

  sig { void }
  def set_article
    @article = Article.friendly.find(params[:slug] || params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end
end
