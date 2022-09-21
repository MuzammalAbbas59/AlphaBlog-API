class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:show, :index,:create ,:new]
  before_action :require_same_user, only: [:edit, :update,:destroy]
  # skip_before_action :verify_authenticity_token

  def show
    @articles = @user.articles
    #.paginate(page: params[:page], per_page:5)
    # render json: @articles
    render json:@user
  end

  def index
    # @users = User.paginate(page: params[:page], per_page: 5)
    @users=User.all
    render json: @users, status: 200
  end

  def new
    @user = User.new
    render json: @user
  end

  def edit
  end

  def create
      @user = User.new(user_params)
      if @user.save
        render json: @user
        session[:user_id] = @user.id
        #flash[:notice] = "Dear #{@user.username}, Welcome to alpha blog"
        #redirect_to articles_path
      else
        render json: { message: " could not create" }
      end
  end

  def update
    if @user.update(user_params)
      render json: { message: "user updated" }
      # flash[:notice] = "updated successfully"
      # redirect_to user_path(@user)
    else
      render json: { message: " could not create" }
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    render json: { message: "user destroyed" }
    # if @user==current_user
    # flash[:notice]="#{@user.username}'s account and articles are deleted"
    # redirect_to articles_path
  end

  private

  def set_user
    # @user = User.find(params[:id])
    if ((User.find_by_id(params[:id])))
      @user = User.find(params[:id])
    else
      render json: { message: "not present" }, status: 200
    end
  end

  def user_params
    params.permit(:username, :email, :password,:admin)
  end

  def require_same_user
    if (current_user != @user && !current_user.admin?)
      render json:{message:"You cannot perform this action"}

      #flash[:alert] = "only #{@user.username} can edit his profile"
      # redirect_to @user
    end
  end
end
