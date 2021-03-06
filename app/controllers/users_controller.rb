class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_user, except: [:create, :login, :timeline]
  # GET /users
  def index
    @users = User.where.not(id: current_user.id)
    @users_following = []
    @users_notfollowing = []
    @users.each do |user|
      if current_user.follows?(user)
        @users_following << user
      else
        @users_notfollowing << user
      end
    end
    @users_following += @users_notfollowing
    @users = @users_following
    render json: @users, scope: current_user, scope_name: :current_user
  end

  # GET /users/1
  def show
    if params[:id] == 'me'
      @user = current_user
      render json: @user, serializer: SimpleUserSerializer
    else
      @user = User.find(params[:id])
      render json: @user, serializer: SimpleUserSerializer
    end
  end

  def timeline
    if current_user
      render json: current_user, serializer: UserPostSerializer
    else
      @posts = Post.all.page(params[:page])
      render json: @posts
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      UserUpdatesMailer.signup_email(@user).deliver_later
      render json: @user, serializer: CompleteUserSerializer
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def login
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        render json: @user, serializer: CompleteUserSerializer
      else
        render json: {error: "Incorrect Password"}, status: :unprocessable_entity
      end
    else
      render json: {error: "Unrecognized Email"}, status: :unprocessable_entity
    end
  end

  def follow
    unless current_user.follows?(User.find(params[:id]))
      current_user.follow!(User.find(params[:id]))
        UserUpdatesMailer.following_email(User.find(params[:id]), current_user).deliver_later
        render json: current_user.reload, serializer: FollowingSerializer
    else
      render json: {error: "You Already Follow This Person"}, status: :conflict
    end
  end

  def unfollow
    if current_user.follows?(User.find(params[:id]))
      current_user.unfollow!(User.find(params[:id]))
        render json: current_user.reload, serializer: FollowingSerializer
    else
      render json: {error: "You Were Not Following This Person"}, status: :conflict
    end
  end

  def following
    if params[:id] == 'me'
      @user = current_user
      render json: @user, serializer: FollowingSerializer
    else
      @user = User.find(params[:id])
      render json: @user, serializer: FollowingSerializer
    end
  end

  def followers
    if params[:id] == 'me'
      @user = current_user
      render json: @user, serializer: FollowersSerializer
    else
      @user = User.find(params[:id])
      render json: @user, serializer: FollowersSerializer
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:username, :email, :password, :avatar)
    end
end
