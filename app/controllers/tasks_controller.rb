class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy, :drag, :show, :toggle_status]

  def index
    if user_signed_in?
      @tasks = current_user.tasks
    end
    @projects = current_user.projects
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to project_path(params[:project_id])
    else
      render :new
    end
  end

  def show
    @finished_tictac = @task.tictacs.finished.count
    @cancel_tictac = @task.tictacs.cancelled.count
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy   
    redirect_to root_path
  end

  # 首頁表單post
  def today_task
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path
    else
      redirect_to root_path, alert: "任務至少要有一個字"
    end  
  end

  # 切換任務狀態
  def toggle_status
    if @task.doing?
      @task.done!
      redirect_to root_path
    else
      @task.doing!
      redirect_to root_path
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
      @tictac.update(task: @task)
      redirect_to list_tictacs_path
    else
      render finished_tictac_path(@tictac)
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
    @task = current_user.tasks.find(params[:id])
  end

end
