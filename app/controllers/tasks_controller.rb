class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    # binding.irb
    if params[:title].present?
      # binding.irb
      # @tasks = Task.all.order(created_at: "ASC")
      # @tasks = Task.where(title: params[:title])
      # ,(params[:page]).per(10)
      @tasks = Task.where("title LIKE ?", "%#{params[:title]}%").page(params[:page]).per(5)
      if params[:status].present?
        @tasks = Task.where("title LIKE ?", "%#{params[:title]}%").where(status: params[:status]).page(params[:page]).per(5)
      end
    elsif params[:status].present?
      @tasks = Task.where(status: params[:status]).page(params[:page]).per(5)
    elsif (params[:sort_priority])
      @tasks = Task.all.order(priority: "ASC").page(params[:page]).per(5)
    elsif (params[:sort_expired])
      @tasks = Task.all.order(deadline: "ASC").page(params[:page]).per(5)
    else
      @tasks = Task.all.order(created_at: "DESC").page(params[:page]).per(5)
    end
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
