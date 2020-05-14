class Api::V1::TictacsController < ApplicationController
  require 'pry'
  skip_before_action :verify_authenticity_token
  before_action :last_tictac, only: [:cancel, :finish]

  def start

    @tictac = current_user.tictacs.build(task_id: params[:task_id])
    
    1. 過期的先expired掉
    2. 撈沒過期的傳回去

    if current_user.tictacs.where(status: 'active').last.start_at + 25.minute < Time.now
      current_user.tictacs.last.finish!
      render json: { status: @tictac.status, end_at: @tictac.end_at }
    elsif
      @tictac.start!
      render json: {user_id: @tictac.user_id, status: @tictac.status, start_at: @tictac.start_at, task_id: @tictac.task_id }
    end

    # if @tictac.start!
    #   render json: {user_id: @tictac.user_id, status: @tictac.status, start_at: @tictac.start_at, task_id: @tictac.task_id }
    # else
    #   render json: { error: "nonoooooo" }, status: 400
    # end

  end

  def cancel
    if @tictac.cancel!
      render json: { status: @tictac.status, end_at: @tictac.end_at }
    else
      render json: { error: "nonoooooo" }, status: 400
    end
  end

  def finish
    if @tictac.finish!
      render json: { status: @tictac.status, end_at: @tictac.end_at }
    else
      render json: { error: "nonoooooo" }, status: 400
    end
  end

  private 

  def last_tictac
    @tictac = current_user.tictacs.last    
  end
end
