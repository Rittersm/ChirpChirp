class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users, serializer: SimpleUserSerializer
  end

  # GET /users/1
  def show
    render json: @user.posts, serializer: SimpleUserSerializer
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
    current_user.follow!(User.find_by(username: params[:username]))
  end

  def unfollow
    current_user.unfollow!(User.find_by(username: params[:username]))
  end

  def following
    render json: current_user.followees(User)
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
