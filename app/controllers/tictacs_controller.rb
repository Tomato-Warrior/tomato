class TictacsController < ApplicationController
  before_action :find_tictac, only: [:edit, :update, :cancel, :finish]
  def index
    @tictacs = current_user.tictacs
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
    if @tictac.update
      @tictac.cancel!
      redirect_to tasks_path, notice: 'Tictac cancelled!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  def finish
    if @tictac.update
      @tictac.finish!
      redirect_to tasks_path, notice: 'Tictac finished!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end


  private
  def find_tictac
    @tictac = Tictac.find(params[:id])
  end
end
