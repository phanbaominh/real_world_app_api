# typed: true
# frozen_string_literal: true

class ArticlesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: [:show]

  class ArticleFields < T::Struct
    const :title, String
    const :description, String
    const :body, String
    const :tag_list, T::Array[String]
  end
  class ArticleParams < T::Struct
    const :article, ArticleFields
  end
  sig { void }
  def create
    article = current_user.articles.build(article_params.serialize)
    if article.save
      render :show
    else
      render json: { errors: article.errors }, status: :unprocessable_entity
    end
  end

  sig { void }
  def show
  end

  sig { void }
  def update
  end

  sig { void }
  def delete
  end

  sig { void }
  def index
  end

  sig { void }
  def feed
  end

  private

  def article_params
    TypedParams[ArticleParams].new.extract!(params).article
  end
end