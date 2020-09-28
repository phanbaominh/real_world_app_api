# frozen_string_literal: true

json.set! user_field do |json|
  json.call(user, :username, :bio, :image)
  json.following current_user ? user.followers.include?(current_user) : false
end
