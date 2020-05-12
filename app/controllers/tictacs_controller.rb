class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show, :cancel, :finish]
  
  def index
  end

  def show
  end

  def create
    @tictac = current_user.tictacs.build(task_id: params[:task_id])
    # @tictac.update(task_id: params[:task_id])

    if @tictac.start!
      # @tictac.start!
      redirect_to tictac_path(@tictac), notice: 'Tictac created!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end
 
  def cancel
    if @tictac.cancel!
      redirect_to tasks_path, notice: 'Tictac cancelled!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  def finish
    if @tictac.finish!
      redirect_to tasks_path, notice: 'Tictac finished!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end

end
