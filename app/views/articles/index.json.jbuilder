# frozen_string_literal: true

json.articles do |json|
  json.array! articles, partial: 'articles/article', as: :article, current_user: current_user
end
json.articlesCount articlesCount
