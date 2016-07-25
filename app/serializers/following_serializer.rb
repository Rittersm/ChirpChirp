class FollowingSerializer < ActiveModel::Serializer

  attributes :id, :username, :email, :avatar, :followees_count, :followers_count, :created_at

  def followees
    object.followees(User)
  end

  has_many :followees, serializer: UserListSerializer

end
