# frozen_string_literal: true

json.article do |json|
  json.call(article, :slug, :title, :description, :body,
            :tagList, :created_at, :updated_at, :favorites_count)
  json.favorited article.favorited?(current_user)
  json.partial! 'profiles/show', user: article.author, current_user: current_user, user_field: :author
end
