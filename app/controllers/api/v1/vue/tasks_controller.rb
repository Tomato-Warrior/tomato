class Api::V1::Vue::TasksController < ApplicationController

  def index
    @task = current_user.tasks
  end


end