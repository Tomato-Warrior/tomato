class TictacsController < ApplicationController
  before_action :last_tictac, only: [:index, :show, :cancel, :finish]
  
  def index
  end

  def show
  end

  def create
    @tictac = current_user.tictacs.build
    @tictac.update(task_id: params[:task_id])

    if @tictac.save
      @tictac.start!
      redirect_to tictacs_path, notice: 'Tictac created!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end
 
  def cancel
    if @tictac.cancel!
      redirect_to tictacs_path, notice: 'Tictac cancelled!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  def finish
    if @tictac.finish!
      redirect_to tictacs_path, notice: 'Tictac finished!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end

end
