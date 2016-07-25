class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :require_user


  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def search
    @found_posts = Post.searched_posts(params[:search])
    @found_users = User.searched_users(params[:search])
    @search_results = @found_users += @found_posts
    if @search_results.any?
      render json: @search_results
    else
      render json: {error: "Nothing Matched Your Search"}, status: 404
    end
 end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.permit(:body)
    end

end
