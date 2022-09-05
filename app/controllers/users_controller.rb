class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Dear #{@user.username}, Welcome to alpha blog"
      redirect_to articles_path
    else
      render "new"
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "updated successfully"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
