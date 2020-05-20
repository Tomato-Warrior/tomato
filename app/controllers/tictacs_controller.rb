class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  layout 'tictac', except: [:list]
  
  def index
  end

  def show
    @task = current_user.tasks.find(params[:task_id])
  end

  def list
    @tictacs = current_user.tictacs
    # @tictacs_start_time = "#{current_user.tictacs.start_at.year}" + "#{@tictacs.start_at.month}"
  end

  private 

  def last_tictac  
    if current_user.tictacs.count == 0
      @tictac = Tictac.new
    else
      @tictac = current_user.tictacs.last
    end 
      
  end
end
