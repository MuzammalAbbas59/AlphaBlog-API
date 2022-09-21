class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  # skip_before_action :verify_authenticity_token

  def show
    if @article
      render json: @article
    else
      render json: { message: "not present" }, status: 201
    end
  end

  def index
    # @articles = Article.paginate(page: params[:page], per_page: 5)
    @articles = Article.all
    render json: @articles, status: 200
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
  #   @article.title=params[:title]
  #   @article.description=params[:description]
  #  # @article.category_ids[]=params[:category_ids=>[]]
    @article.user = current_user
    # render json:@article,status: :created
    debugger
    if @article.save
      # flash[:notice] = "created successfully"
      render json: @article, status: :created
      #redirect_to (@article)
    else
      #   # render "new"
      #   # redirect_to (@article)
      render json: { message: "not created" }, status: 201
    end
  end

  def update
    if @article.update(article_params)
    # @article.title=params[:title]
    # @article.description=params[:description]
    #   #flash[:notice] = "updated successfully"
      # redirect_to (@article)
      render json: { message: "updated" }, status: 200
    else
      # render "edit"
      render json: { message: "not updated" }, status: 200
    end
  end

  def destroy
    if @article.destroy
      render json: {message:"deleted"}
    else
      render json: { message: "not deleted" }
      #   # redirect_to articles_path, status: :see_other
    end
  end

  private

  def set_article
    if ((Article.find_by_id(params[:id])))
      @article = Article.find(params[:id])
    else
      render json: { message: "not present" }, status: 200
    end
  end

  def article_params
    params.permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if ((current_user != @article.user) && !current_user.admin?)
      # flash[:alert] = "only #{@article.user.username} can edit or delete this article"
        render json:{message:"You cannot delete this article"}
      # redirect_to @article
    end
  end
end
