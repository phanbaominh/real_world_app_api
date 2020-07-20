# typed: strict
# frozen_string_literal: true

class UsersController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!

  class UserFields < T::Struct
    const :email, T.nilable(String)
    const :username, T.nilable(String)
    const :image, T.nilable(String)
    const :password, T.nilable(String)
    const :bio, T.nilable(String)
  end

  class UserParams < T::Struct
    const :user, UserFields
  end

  sig { void }
  def show; end

  sig { void }
  def update
    if current_user.update(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  sig { returns(T::Hash[String, String]) }
  def user_params
    TypedParams[UserParams].new.extract!(params).user.serialize
  end
end
