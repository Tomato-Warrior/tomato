class TasksController < ApplicationController
  before_action :find_task, only: [:edit, :update, :destroy, :drag, :show]

  def index
    if current_user
      @tasks = current_user.tasks.includes(:user).order(project_id: :desc)
    end
    @projects = current_user.projects
  end
  
  def new
    @task = Task.new
  end

  def create

    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to project_path(params[:project_id]), notice: "成功喵~任務新增成功"
    else
      render :new
    end
  end

  def show
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      redirect_to project_path(@task.project_id), notice: '成功編輯喵'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy   
    redirect_to project_path(@task.project_id), notice: '成功刪除 喵'
  end

  # drag tasks' items
  def drag
    @task.insert_at(params[:position].to_i)
    head :ok
  end

  private
  def task_params
    params.require(:task).permit(:task_name, 
                                 :description,
                                 :tomato_num,
                                 :task_date,
                                 :project_name,
                                 :project_id,
                                 tag_items: []
                                )
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
