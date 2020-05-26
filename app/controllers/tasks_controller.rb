class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy, :drag, :show, :toggle_status]

  def index
    if current_user
      @tasks = current_user.tasks.includes(:user)
    end
    @projects = current_user.projects
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to project_path(params[:project_id]), notice: "任務新增成功喵"
    else
      render :new
    end
  end

  def show
    @finished_tictac = Tictac.where('task_id = ?', params[:id] ).finished.count
    @cancel_tictac = Tictac.where('task_id = ?', params[:id] ).cancelled.count
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to project_path(@task.project_id), notice: '任務成功編輯喵'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy   
    redirect_to project_path(@task.project_id), notice: '任務成功刪除喵'
  end

  # 首頁表單post
  def today_task
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: "任務新增成功喵"
    else
      render :new
    end  
  end

  # 切換任務狀態
  def toggle_status
    if @task.doing?
      @task.done!
      redirect_to project_path(@task.project_id)
    else
      @task.doing!
      redirect_to project_path(@task.project_id)
    end
  end

  # drag tasks' items
  def drag
    @task.insert_at(params[:position].to_i)
    head :ok
  end

  # finished tictac add new task
  def finished_tictac
    @task = current_user.tasks.build(task_params)
    if @task.save
      @tictac = Tictac.find(params[:tictac_id])
      @tictac.update(task_id: @task.id)
      redirect_to list_tictacs_path
    else
      render finished_tictac_path(@tictac.id)
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, 
                                 :description,
                                 :expect_tictacs,
                                 :date,
                                 :project_id,
                                 tag_items: []
                                )
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
