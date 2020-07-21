# frozen_string_literal: true

json.article do |json|
  json.partial! partial: 'articles/article', article: article, current_user: current_user
end
