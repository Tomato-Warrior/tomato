class Api::TictacsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
<<<<<<< HEAD
<<<<<<< HEAD
    tictac = Tictac.find(params[:id])
    render json: {status: 'process', start_at: Time.now}
=======
    render json: {status: 'processing', start_at: Time.now}
>>>>>>> add tictac api
=======
    tictac = Tictac.find(params[:id])
    render json: {status: 'process', start_at: Time.now}
>>>>>>> add tictac action
  end

  def cancel
    render json: {status: 'failed', end_at: Time.now}
  end

  def finish
    render json: {status: 'finished', end_at: Time.now}
  end
end
