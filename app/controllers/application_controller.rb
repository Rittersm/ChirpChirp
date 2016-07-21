class ApplicationController < ActionController::API

  private

  def current_user
    if params[:api_token] && User.exists?(api_token: params[:api_token])
      @user ||= User.find_by(api_token: params[:api_token])
    end
    @user
  end

  def require_user
    render json: {errors:[{error: "You must be logged in"}]}, status: :forbidden unless current_user
  end

end
