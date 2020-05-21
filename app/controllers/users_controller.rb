class UsersController < ApplicationController
  before_action :user_check, only: [:show]
  before_action :login_check, only: [:new]
  skip_before_action :login_required, only:[:new, :create,]

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path(@user.id)
    else
      render :new
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def login_check
      if logged_in?
        redirect_to tasks_path, notice: '既にログインしています'
      end
    end

    def user_check
      redirect_to root_path, notice: '他のユーザー情報は見れません' unless current_user.id == params[:id].to_i || current_user.admin?
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
