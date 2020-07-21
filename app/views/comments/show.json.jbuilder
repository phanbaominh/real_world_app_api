# frozen_string_literal: true

json.comment do |json|
  json.partial! 'comments/comment', comment: comment, current_user: current_user
end
