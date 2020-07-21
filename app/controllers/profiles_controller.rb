# typed: true
# frozen_string_literal: true

class ProfilesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: [:show]
  before_action :set_user

  sig { void }
  def show
    render_profile
  end

  sig { void }
  def follow
    current_user.follow(@user)
    render_profile
  end

  sig { void }
  def unfollow
    current_user.unfollow(@user)
    render_profile
  end

  private

  sig { void }
  def set_user
    current_user_or_nil
    head :not_found unless (@user = User.find_by(username: params[:username]))
  end

  sig { returns(Hash) }
  def user_options
    { user: @user, current_user: @current_user, user_field: :profile }
  end

  sig { void }
  def render_profile
    render partial: 'profile', locals: user_options
  end
end
