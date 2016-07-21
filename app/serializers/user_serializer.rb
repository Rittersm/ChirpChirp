class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :api_token, :avatar
end
