class Post < ApplicationRecord

  belongs_to :user

  validates :body, presence: true, length: { maximum: 170 }

  default_scope { order(created_at: :desc) }

  def self.searched_posts(params)
    where('body ILIKE ?', "%#{params}%".downcase)
  end

end
