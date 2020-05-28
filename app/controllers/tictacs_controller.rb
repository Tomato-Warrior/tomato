class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  before_action :find_tictac, only: [:cancelled, :finished, :update]
  layout 'tictac', except: [:list, :cancelled, :finished]
  
  def index
  end

  def show
    @task = current_user.tasks.find(params[:task_id])
  end

  def update
    if @tictac.update(tictac_params)
      redirect_to list_tictacs_path, notice: '時鐘成功編輯喵'
    else
      render list_tictacs_path
    end
  end

  def list
    @tictacs_cancelled = current_user.tictacs.cancelled.order(created_at: :desc)
    @tictacs_finished = current_user.tictacs.finished.order(created_at: :desc)
  end

  def cancelled
    @task = Task.new
  end

  def finished
    @task = Task.new
  end


  private 

  def last_tictac  
    if current_user.tictacs.any?
      @tictac = current_user.tictacs.last
    else
      @tictac = Tictac.new
    end 
  end

  def tictac_params
    params.require(:tictac).permit(:status,
                                   :reason,
                                   :start_at,
                                   :end_at,
                                   :task_id
                                  )
  end

  def find_tictac
    @tictac = Tictac.find(params[:id])
  end

end