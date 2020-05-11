class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    task_list if current_user
  end
  def new
    @task = Task.new
  end
  def create
    @task = current_user.task.build(task_params)

    if @task.save
      redirect_to tasks_path, notice: "成功喵~任務新增成功"
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
      redirect_to tasks_path, notice: '成功編輯喵'
    else
      render :edit
    end
  end
  def destroy
    @task.destroy   
    redirect_to tasks_path, notice: '成功刪除 喵'
  end

  private

  def task_params
    params.require(:task).permit(:task_name, 
                                :description,
                                :tomato_num,
                                :task_date,
                                :project_id,
                                { tag_items: [] }
                                )
  end
  def find_task
    @task = Task.find(params[:id])
  end
  def task_list
    @tasks = current_user.tasks
  end


end
