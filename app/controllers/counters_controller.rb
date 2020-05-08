class CountersController < ApplicationController
  before_action :find_counter, only: [:edit, :update]
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

  def edit
    
  end
 

  private
  def find_counter
    @counter = Counter.find(params[:id])
  end
end
