class Api::V1::TictacsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :last_tictac, only: [:cancel, :finish]

  def start
    if current_user.tictacs.count != 0  #current_user.tictacs.any?
      find_expired_tictac
    end
      @tictac = current_user.tictacs.build(task_id: params[:task_id])
    
    if @tictac.start!
      render json: { user_id: @tictac.user_id, status: @tictac.status, start_at: @tictac.start_at, task_id: @tictac.task_id, id: @tictac.id, data: params}
    else
      render json: { error: "nonoooooo" }, status: 400
    end

  end

  def cancel
    if params[:reason].length != 0
      @tictac.update(reason: params[:reason])
    end
    if @tictac.cancel!
      render json: { user_id: @tictac.user_id, status: @tictac.status, start_at: @tictac.start_at, task_id: @tictac.task_id, id: @tictac.id, data: params}
    else
      render json: { error: "no" }, status: 400
    end
  end

  def finish
    if @tictac.finish!
      render json: { state: 'ok' }
    else
      render json: { error: "no" }, status: 400
    end
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end

  def find_expired_tictac
    if current_user.tictacs.last.status == 'active'
      current_user.tictacs.last.cancel!
    end
  end

end
