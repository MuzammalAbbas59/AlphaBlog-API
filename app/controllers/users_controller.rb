class UsersController < ApplicationController
    before_action :set_user , only: [ :edit]

    def new
        @user=User.new
    end 

    def edit
    end

    def create
       
       @user=User.new(user_params)
       if @user.save
          flash[:notice]="Dear #{@user.username}, Welcome to alpha blog" 
          redirect_to articles_path
       else
       render 'new'
       end
    end

    
    def index

    end    

    private 
    def set_user
    @article = User.find(params[:id])  
    end

    def user_params
    params.require(:user).permit(:username,:email,:password)   
    end
end
