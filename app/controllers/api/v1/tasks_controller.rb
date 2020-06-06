class Api::V1::TasksController < ApiController
  before_action :authenticate_user_token
  
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

end