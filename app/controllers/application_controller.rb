class ApplicationController < ActionController::Base
  helper_method :current_user, :loggedin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def loggedin?
    !!current_user
  end

  def require_user
    if !loggedin?
      render json:{message:"You must be login to perform this action"}
      # flash[:alert] = "You must be login to perform this action"
      # redirect_to login_path
    end
  end
end
