class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]
  before_action :require_user
  # GET /posts
  def index
    @posts = current_user

    render json: @posts
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def search
    @found_posts = Post.searched_posts(params[:search])
    @found_users = User.searched_users(params[:search])
    @search_results = @found_users += @found_posts
    render json: @search_results
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
