# frozen_string_literal: true
json.article do |json|
  json.call(article, :slug, :title, :description, :body,
            :tagList, :created_at, :updated_at, :favorites_count)
  json.favorited article.favorited?(user)
  json.partial! 'profiles/show', user: user, current_user: current_user, user_field: :author
end
