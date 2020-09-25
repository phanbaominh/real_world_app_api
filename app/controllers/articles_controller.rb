# typed: true
# frozen_string_literal: true

class ArticlesController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_article, except: %i[create feed index]
  before_action :check_author, except: %i[show create feed index]

  class ArticleFields < T::Struct
    const :title, T.nilable(String)
    const :description, T.nilable(String)
    const :body, T.nilable(String)
    const :tag_list, T.nilable(T::Array[String])
  end

  class ArticleParams < T::Struct
    const :article, ArticleFields
  end

  class ArticlesParams < T::Struct
    const :author, T.nilable(String)
    const :favorited, T.nilable(String)
    const :limit, T.nilable(Integer)
    const :offset, T.nilable(Integer)
    const :tag, T.nilable(String)
  end

  sig { void }
  def create
    article = current_user.articles.build(article_params.serialize.slice!('tag_list'))
    article.add_tags!(article_params.tag_list)
    if article.save
      @article = article
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
    if @article.update(article_params.serialize.slice!('tag_list'))
      render_article
    else
      render json: { errors: @article.errors }, status: :unprocessable_entity
    end
  end

  sig { void }
  def destroy
    @article.destroy ? head(:ok) : head(:unprocessable_entity)
  end

  sig { void }
  def index
    articles = Article.all.includes(:tags, :author, :favored_users)
    ap = articles_params

    articles = articles.authored_by(User.find_by(username: ap.author)) if ap.author
    articles = articles.tagged_with(Tag.find_by(name: ap.tag)) if ap.tag
    articles = articles.favorited_by(User.find_by(username: ap.favorited)) if ap.favorited
    articles = articles.limit(ap.limit) if ap.limit
    articles = articles.offset(ap.offset) if ap.offset

    render_articles(articles)
  end

  sig { void }
  def feed
    ap = articles_params
    articles = current_user.followed_articles
    articles = articles.limit(ap.limit) if ap.limit
    articles = articles.offset(ap.offset) if ap.offset

    render_articles(articles)
  end

  private

  sig { returns(ArticleFields) }
  def article_params
    TypedParams[ArticleParams].new.extract!(params).article
  end

  sig { returns(ArticlesParams) }
  def articles_params
    TypedParams[ArticlesParams].new.extract!(params)
  end

  sig { void }
  def check_author
    head :forbidden unless @article.authored_by?(current_user)
  end

  sig { void }
  def render_article
    render :show, locals: { article: @article, current_user: current_user_or_nil }
  end

  sig { params(articles: Article::ActiveRecord_Relation).void }
  def render_articles(articles)
    render :index, locals: { articles: articles, current_user: current_user_or_nil }
  end
end
