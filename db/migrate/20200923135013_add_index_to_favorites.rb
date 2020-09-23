# typed: true
# frozen_string_literal: true

class AddIndexToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_index :favorites, %i[user_id article_id], unique: true
    add_index :follows, %i[following_id follower_id], unique: true
  end
end
