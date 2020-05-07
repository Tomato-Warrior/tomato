class CountersController < ApplicationController
  def index
  end

  def create

    @counter = current_user.counters.build

    if @counter.save
      redirect_to tasks_path, notice: 'Counter created!'
    else
      byebug 
      redirect_to tasks_path, notice: 'Counter failed!'
    end
  end

  private 
  def counter_params
    # params.require(:counter).permit(:reason)
  end
end
