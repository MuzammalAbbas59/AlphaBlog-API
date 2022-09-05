class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "logged in Successfully"
      redirect_to user
    else
      flash.now[:alert] = "Wrong Password or Email"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "logged Out Successfully"
    redirect_to login_path, status: :see_other
  end
end
