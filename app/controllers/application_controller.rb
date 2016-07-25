class ApplicationController < ActionController::API

  private

  def current_user
    if params[:api_token] && User.exists?(api_token: params[:api_token])
      @current_user ||= User.find_by(api_token: params[:api_token])
    end
    @current_user
  end

  def require_user
    render json: {errors:[{error: "You must be logged in"}]}, status: :forbidden unless current_user
  end

  def forbid_user
    render json: {error: "You are already logged in"}, status: :forbidden if current_user
  end

end
