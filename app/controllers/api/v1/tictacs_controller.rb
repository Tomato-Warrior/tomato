class Api::V1::TictacsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
    @tictac = current_user.tictacs.build(task_id: params[:task_id])
    
    if @tictac.start!
      # @tictac.start!
      render json: {user_id: @tictac.user_id, status: @tictac.status, start_at: @tictac.start_at, task_id: @tictac.task_id }
    else
      render json: { error: "nonoooooo" }, status: 400
    end

  end

  def cancel
    render json: {status: 'failed', end_at: Time.now}
  end

  def finish
    render json: {status: 'finished', end_at: Time.now}
  end
end
