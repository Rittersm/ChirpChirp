class Post < ApplicationRecord

  belongs_to :user

  validates :body, presence: true, length: { maximum: 170 }

  def self.searched_posts(params)
    @searched_posts = Post.where('body ILIKE ?', "%#{params}%".downcase)
  end

end
