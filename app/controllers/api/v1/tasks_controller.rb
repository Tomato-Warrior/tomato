class Api::V1::TasksController < ApiController
  before_action :authenticate_user_token
  
  def gettasks
    tasks = current_user.tasks
    render json: { message: "ok", tasks: tasks }, status: 200
  end

  # 收到token & task_id, then create a tictac, return tictac_id
  def startwork
    task = current_user.tasks.find(params["task_id"])
    @tictac = Tictac.new(user_id: current_user.id, task_id: task.id)
    @tictac.start!
    render json: { message: "tictac start", tictac_id: @tictac.id }, status: 200
  end

end