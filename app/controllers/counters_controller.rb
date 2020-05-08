class CountersController < ApplicationController
  def index
  end

  def create

    @counter = current_user.counters.build
    @counter.update(task_id: params[:task_id])

    if @counter.save
      redirect_to tasks_path, notice: 'Counter created!'
    else
      redirect_to tasks_path, notice: 'Counter failed!'
    end
  end
 
end
