# frozen_string_literal: true
json.profile do |json|
  json.call(@user, :username, :bio, :image)
  json.following current_user ? current_user.followed?(@user) : false
end
