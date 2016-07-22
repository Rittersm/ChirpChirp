class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :api_token, :avatar, :created_at
end
