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
  before_action :cors_set_controll_access_headers
  before_action :authenticate_user_with_jwt

  def cors_preflight_check
    return unless request.method == :options

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*'
    headers['Access-Control-Max-Age'] = '1728000'
    render text: '', content_type: 'text/plain'
  end

  private

  def cors_set_controll_access_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
  end
  # transform all param key to underscore for easier handling
  # due to API spec requiring json request's key be in camelCase
  sig { void }
  def underscore_params!
    params_hash = params.to_unsafe_hash
    params_hash.deep_transform_keys!(&:underscore)
    self.params = ActionController::Parameters.new(params_hash)
  end

  sig { void }
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  sig { void }
  def authenticate_user_with_jwt
    if request.headers['Authorization'].blank?
      @current_user_id = nil
      return
    end

    authenticate_or_request_with_http_token do |token|
      payload = JWT.decode(token, Rails.application.credentials[:SECRET_KEY_BASE]).first
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
