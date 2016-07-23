class PostSerializer < ActiveModel::Serializer

  attributes :body, :created_at, :user

  def user
    {
      id: object.user_id,
      username: object.user.username,
      email: object.user.email,
      avatar: object.user.avatar,
      followees_count: object.user.followees_count,
      followers_count: object.user.followers_count,
      created_at: object.user.created_at
    }
  end

end
