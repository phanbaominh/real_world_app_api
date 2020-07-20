# typed: true
# frozen_string_literal: true

class ArticlesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: %i[show feed index]
  before_action :set_article, except: %i[create feed index]
  before_action :check_author, except: %i[show create feed index]

  class ArticleFields < T::Struct
    const :title, T.nilable(String)
    const :description, T.nilable(String)
    const :body, T.nilable(String)
    const :tag_list, T.nilable(T::Array[String])
    const :author, T.nilable(String)
    const :favorited, T.nilable(String)
    const :limit, T.nilable(Integer)
    const :offset, T.nilable(Integer)
    const :tag, T.nilable(String)
  end

  class ArticleParams < T::Struct
    const :article, ArticleFields
  end

  sig { void }
  def create
    article = current_user.articles.build(article_params.serialize.slice!(:tag_list))
    article.add_tags!(article_params.tag_list)
    if article.save
      render_article
    else
      render json: { errors: article.errors }, status: :unprocessable_entity
    end
  end

  sig { void }
  def show
    render_article
  end

  sig { void }
  def update
    if @article.update(article_params.serialize)
      render_article
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  sig { void }
  def delete
    @article.destroy
  end

  # rubocop:disable Metrics/AbcSize
  sig { void }
  def index
    articles = Article.all
    ap = article_params

    articles = articles.authored_by(User.find_by(username: ap.author)) if ap.author
    articles = articles.tagged_with(ap.tag) if ap.tag
    articles = articles.favorited_by(User.find_by(username: ap.favorited)) if ap.favorited
    articles = articles.limit(ap.limit) if ap.limit
    articles = articles.offset(ap.offset) if ap.offset

    render_articles(articles)
  end
  # rubocop:enable Metrics/AbcSize
  sig { void }
  def feed
    ap = article_params
    articles = Article.favorited_by(current_user.followings)
    articles = articles.limit(ap.limit) if ap.limit
    articles = articles.offset(ap.offset) if ap.offset

    render_articles(articles)
  end

  private

  sig { returns(ArticleFields) }
  def article_params
    TypedParams[ArticleParams].new.extract!(params).article
  end

  sig { void }
  def set_article
    head :not_found unless (@article = Article.friendly.find(params[:slug]))
  end

  sig { void }
  def check_author
    head :forbidden unless @article.authored_by?(current_user)
  end

  sig { void }
  def render_article
    render :show, locals: { article: @article, current_user: current_user }
  end

  sig { params(articles: Article::ActiveRecord_Relation).void }
  def render_articles(articles)
    render :index, locals: { articles: articles }
  end
end
