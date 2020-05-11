class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  def index
    # binding.irb
    if params[:title].present?
      # binding.irb
      # @tasks = Task.all.order(created_at: "ASC")
      # @tasks = Task.where(title: params[:title])
      @tasks = Task.where("title LIKE ?", "%#{params[:title]}%")
    elsif params[:status].present?
      @tasks = Task.where(status: params[:status])
    elsif (params[:sort_priority])
      @tasks = Task.all.order(priority: "ASC")
    else
      @tasks = Task.all.order(created_at: "DESC")
    end
  end

  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'タスクを作成しました！'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'タスクを削除しました'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :content, :deadline, :priority, :status)
    end
end
