class Api::V1::TasksController < ApiController
  before_action :authenticate_user_token, only: [:gettasks, :startwork]
  
  def gettasks
    tasks = current_user.tasks
    render json: { message: "ok", tasks: tasks }, status: 200
  end

  def startwork
    task = current_user.tasks.find(params["task_id"])
    @tictac = Tictac.new(user_id: current_user.id, task_id: task.id)
    @tictac.start!
    render json: { message: "tictac started", tictac_id: @tictac.id }, status: 200
  end

  def finishwork
    task = current_user.tasks.find(params["task_id"])
    tictac = current_user.tictacs.find(params["tictac_id"])
    tictac.finish!
    render json: { message: "tictac finished" }, status: 200
  end

  def cancelwork
    task = current_user.tasks.find(params["task_id"])
    tictac = current_user.tictacs.find(params["tictac_id"])
    tictac.cancel!
    render json: { message: "tictac finished" }, status: 200
  end

  # Vue API
  def index
    @project = current_user.projects.find(params[:project_id])
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    task_ids = @project.tasks.ids
    @tasks = @project.tasks
    @tictac_count = Tictac.where(task_id: task_ids).finished.count
    @project_expect_time = project_expect_time
    @today_tasks = @project.tasks.where(created_at: range)

    render format: :json
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      render json: { state: 'ok', task: @task }
    else
      render json: { state: 'create error' }
    end
  end

  def update
    render json: { state: 'update ok' }
  end

  def destroy 
    task = current_user.tasks.find(params[:id])
    task.destroy
    render json: { state: 'ok', task: { id: task.id, status: task.status }}
  end

  def toggle_status
    task = current_user.tasks.find(params[:id])
    if task.status == 'doing'
      task.done!
    else
      task.doing!
    end
    render json: { state: 'ok', task: { id: task.id, status: task.status }}
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

  def project_expect_time
    project = current_user.projects.find(params[:project_id])
    tictac_hour = project.tasks.doing.sum(:expect_tictacs) * 1500.0 / 3600
    tictac_hour.round(tictac_hour % 10 == 0 ? 0 : 1)
  end

end