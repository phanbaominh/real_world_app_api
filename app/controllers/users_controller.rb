# typed: true
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
    if T.must(current_user).update(user_params.user.serialize)
      render :show
    else
      render json: { errors: T.must(current_user).errors }, status: :unprocessable_entity
    end
  end

  private

  sig { returns(UserParams) }
  def user_params
    TypedParams[UserParams].new.extract!(params)
  end
end
