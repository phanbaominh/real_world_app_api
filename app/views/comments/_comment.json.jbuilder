# frozen_string_literal: true

json.call(comment, :id, :created_at, :updated_at, :body)
json.partial! 'profiles/profile', user: comment.user, current_user: current_user, user_field: :author
