class TictacsController < ApplicationController
  before_action :find_counter, only: [:edit, :update]
  def index
  end

  def create
    @tictac = current_user.tictacs.build
    @tictac.update(task_id: params[:task_id])

    if @tictac.save
      redirect_to tasks_path, notice: 'Tictac created!'
    else
      redirect_to tasks_path, notice: 'Tictac failed!'
    end
  end

  def edit
    
  end
 

  private
  def find_counter
    @tictac = Tictac.find(params[:id])
  end
end
