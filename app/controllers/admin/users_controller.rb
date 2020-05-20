class Admin::UsersController < ApplicationController
  before_action :admin_user, only: [:new, :index, :show, :edit, :update, :destroy]
  before_action :login_check, only: [:new]
  
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "adminユーザーを登録しました"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "adminユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "adminユーザーを削除しました"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def admin_user
    if not current_user.admin
      flash[:notice] = "管理者ではありません"
      redirect_to(root_path)
    end
  end

  def login_check
    if logged_in?
      redirect_to tasks_path, notice: '既にログインしています'
    end
  end

end
