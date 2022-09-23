class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update,:destroy]
  # before_action :require_user, except: [:show, :index]
  # before_action :require_admin, except: [:index, :show,:edit]
   skip_before_action :verify_authenticity_token

  def new
    @category = Category.new
  end

  def edit
  end

  def destroy
    if @category.destroy
      render json: { message: "category destroyed" }
    else
      render json: { message: "category not destroyed" }
    end
  end

  def update
      if @category.update(category_params)
      render json: { message: "Category Updated" }

      #   flash[:notice] = "updated successfully"
      #   redirect_to category_path(@category)
    else
      #   render "edit"
      render json: { message: "not updated" }
    end
  end

  def index
    # @categories = Category.paginate(page: params[:page], per_page: 5)
    @categories = Category.all
    render json: @categories
  end

  def show
    # @articles = @category.articles.paginate(page: params[:page], per_page:5)
    render json: @category
  end

  def create
    @category = Category.new(category_params)
    debugger
    if @category.save
      # flash[:notice] = "created successfully"
      # redirect_to @category
      debugger
      render json: { message: " created " }
    else
      debugger
      render json: { message: " could not create" }
      # render "new"
    end
  end

  private

  def category_params

    params.permit(:name)
  end

  def set_category
    if ((Category.find_by_id(params[:id])))
      @category = Category.find(params[:id])
    else
      render json: { message: "not present" }, status: 200
    end
  end

  def require_admin
    if !(loggedin? && current_user.admin?)
      render json: { message: "only admin can perform this action" }, status: 200
      # flash[:alert] = "Only Admin can perform this action"
      # redirect_to categories_path
    end
  end
end
