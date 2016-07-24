class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :require_user, except: [:create, :login]

  # GET /users
  def index
    @users = User.all

    render json: @users, each_serializer: UserListSerializer
  end

  # GET /users/1
  def show
    render json: current_user, serializer: SimpleUserSerializer
  end

  def timeline
    render json: current_user, serializer: UserPostSerializer
  end

  def personal
    render json: current_user, serializer: SimpleUserSerializer
  end


  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
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
    unless current_user.follows?(User.find_by(id: params[:id]))
      current_user.follow!(User.find_by(id: params[:id]))
        render json: current_user, serializer: SimpleUserSerializer
    else
      render json: {error: "You Already Follow This Person"}, status: :conflict
    end
  end

  def unfollow
    if current_user.follows?(User.find_by(id: params[:id]))
      current_user.unfollow!(User.find_by(id: params[:id]))
        render json: current_user, serializer: SimpleUserSerializer
    else
      render json: {error: "You Were Not Following This Person"}, status: :conflict
    end
  end

  def following
    render json: current_user, serializer: FollowingSerializer
  end

  def followers
    render json: current_user, serializer: FollowersSerializer
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
