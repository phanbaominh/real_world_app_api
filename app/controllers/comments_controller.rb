# typed: true
# frozen_string_literal: true

class CommentsController < ApplicationController
  extend T::Sig
  before_action :authenticate_user!, except: :index
  before_action :set_article
  before_action :set_comment, only: :destroy

  class CommentFields < T::Struct
    const :body, String
  end

  class CommentParams < T::Struct
    const :comment, CommentFields
    const :article_slug, String
  end

  sig { void }
  def index
    render :index, locals: { comments: @article.comments, current_user: current_user_or_nil }
  end

  sig { void }
  def destroy
    @comment.destroy
    head :ok
  end

  sig { void }
  def create
    comment = build_comment
    if comment.save
      render :show, locals: { comment: comment, user: current_user }
    else
      render json: { errors: comment.errors }, status: :unprocessable_entity
    end
  end

  private

  sig { returns(CommentFields) }
  def comment_params
    TypedParams[CommentParams].new.extract!(params).comment
  end

  sig { returns(Comment) }
  def build_comment
    current_user.comments.build(
      article: @article,
      body: comment_params.body
    )
  end

  sig { void }
  def set_article
    @article = Article.friendly.find(params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    head :not_found
  end

  sig { void }
  def set_comment
    head :not_found unless (@comment = @article.comments.find_by(id: params[:id]))
  end
end
