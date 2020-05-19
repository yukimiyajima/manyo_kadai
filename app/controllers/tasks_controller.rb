class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    # @tasks = current_user.tasks.find(params[:id]).page(params[:page]).per(5)
    @tasks = current_user.tasks.find_title(params[:title]).find_status(params[:status]).sort_column(params[:column],params[:sort]).page(params[:page]).per(5)
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: 'タスクを作成しました！'
    else
      render :new
    end
  end

  def confirm
    @blog = current_user.tasks.build(task_params)
    render :new if @blog.invalid?
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'タスクを削除しました'
  end

  private
    
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content, :deadline, :priority, :status)
    end

end
