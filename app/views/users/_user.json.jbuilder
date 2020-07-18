# frozen_string_literal: true
json.call(user, :email, :username, :bio, :image)
json.token user.generate_jwt
