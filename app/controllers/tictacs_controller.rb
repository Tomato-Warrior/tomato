class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  layout 'tictac', except: [:list]
  
  def index
  end

  def show
    @task = current_user.tasks.find(params[:task_id])
  end

  def edit
  end

  def list
    @tictacs_cancelled = current_user.tictacs.cancelled
    @tictacs_finished = current_user.tictacs.finished
  end

  private 

  def last_tictac  
    if current_user.tictacs.count == 0
      @tictac = Tictac.new
    else
      @tictac = current_user.tictacs.last
    end 
    #@tictac = current_user.tictacs.last || Tictac.new
  end
end
