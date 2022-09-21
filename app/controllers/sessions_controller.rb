class SessionsController < ApplicationController
   skip_before_action :verify_authenticity_token

  def new
    render json:{message:"welcome to login page"}
  end

  def create
    
    if (session[:user_id] != nil)
       render json: { message: "You are already login" }
    else
      user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          render json: { message: "Logged in Successfully" }
          #   flash[:notice] = "logged in Successfully"
          # redirect_to user
        else
          # flash.now[:alert] = "Wrong Password or Email"
          render json: { message: "wrong Password or Email" }
          # render "new"
        end
    end
  end

  def destroy
    if (session[:user_id] == nil)
      render json: { message: "You need to login to logout" }
    else
      session[:user_id] = nil
      render json: { message: "logged out successfully" }
      # flash[:notice] = "logged Out Successfully"
      # redirect_to login_path, status: :see_other
    end
  end
end
