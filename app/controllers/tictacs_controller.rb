class TictacsController < ApplicationController
  # before_action :current_tictac, only: [:cancel, :finish]
  
  def index
    @tictacs = current_user.tictacs
    @tictac = current_user.tictacs.last
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

  def edit
  end
 
  def cancel
    @tictac = current_user.tictacs.last

    if @tictac.cancel!
      redirect_to tictacs_path, notice: 'Tictac cancelled!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  def finish
    @tictac = current_user.tictacs.last
    if @tictac.finish!
      redirect_to tictacs_path, notice: 'Tictac finished!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end


end
