class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show]
  
  def index
  end

  def show
    @task = current_user.tasks.find(params[:task_id])
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end
end
