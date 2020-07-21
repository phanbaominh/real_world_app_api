# typed: true
# frozen_string_literal: true

class FavoritesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!
  before_action :set_article

  def create
    current_user.favorite(@article)
    render 'articles/show', locals: { article: @article }
  end

  def destroy
    current_user.unfavorite(@article)
    render 'articles/show', locals: { article: @article }
  end
end
