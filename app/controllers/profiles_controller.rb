# typed: true
# frozen_string_literal: true

class ProfilesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: [:show]
  before_action :set_user

  sig { void }
  def show; end

  sig { void }
  def follow
    T.must(current_user).follow(@user)
    render :show
  end

  sig { void }
  def unfollow
    T.must(current_user).unfollow(@user)
    render :show
  end

  private

  sig { void }
  def set_user
    @user = User.find_by(username: params[:username])
  end
end
