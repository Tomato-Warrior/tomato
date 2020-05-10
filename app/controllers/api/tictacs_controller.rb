class Api::TictacsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def start
<<<<<<< HEAD
    tictac = Tictac.find(params[:id])
    render json: {status: 'process', start_at: Time.now}
=======
    render json: {status: 'processing', start_at: Time.now}
>>>>>>> add tictac api
  end

  def cancel
    render json: {status: 'failed', end_at: Time.now}
  end

  def finish
    render json: {status: 'finished', end_at: Time.now}
  end
end
