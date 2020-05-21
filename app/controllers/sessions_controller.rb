class SessionsController < ApplicationController
  skip_before_action :login_required
  before_action :login_check, only: [:new]
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path(user.id)
      flash[:notice] = 'ログインしました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  def login_check
    if logged_in?
      redirect_to tasks_path, notice: '既にログインしています'
    end
  end

end
