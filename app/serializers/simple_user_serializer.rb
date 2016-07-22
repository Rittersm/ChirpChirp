class SimpleUserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :avatar, :created_at
end
