class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  before_action :find_tictac, only: [:cancelled, :finished, :update]
  layout 'tictac', except: [:list, :cancelled, :finished]
  
  def index
    time_setting = current_user.time_setting
    if time_setting == "二十五分鐘"
      @time_setting = 1500
    elsif time_setting == "二十分鐘"
      @time_setting = 1200
    elsif time_setting == "十五分鐘"
      @time_setting = 900
    elsif time_setting == "十分鐘"
      @time_setting = 600
    elsif time_setting == "十秒鐘"
      @time_setting = 10
    else
      @time_setting = 5
    end
  end

  def show
    @task = current_user.tasks.find(params[:task_id])

    time_setting = current_user.time_setting
    if time_setting == "二十五分鐘"
      @time_setting = 1500
    elsif time_setting == "二十分鐘"
      @time_setting = 1200
    elsif time_setting == "十五分鐘"
      @time_setting = 900
    elsif time_setting == "十分鐘"
      @time_setting = 600
    elsif time_setting == "十秒鐘"
      @time_setting = 10
    else
      @time_setting = 5
    end
  end

  def update
    if @tictac.update(tictac_params)
      redirect_to list_tictacs_path
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