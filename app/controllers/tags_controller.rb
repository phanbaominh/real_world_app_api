# typed: true
# frozen_string_literal: true

class TagsController < ApplicationController
  extend T::Sig
  sig { void }
  def index
    render :index, locals: { tags: Tag.all.map(&:name) }
  end
end
