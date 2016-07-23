class PostSerializer < ActiveModel::Serializer

  attributes :body, :created_at, :user

  def user
    {id: object.user_id, username: object.user.username,  email: object.user.email, avatar: object.user.avatar}
  end

end
