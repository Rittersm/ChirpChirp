class UserSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :followees_count, :followers_count, :is_following, :created_at

  def is_following
    current_user.follows?(object)
  end

end
