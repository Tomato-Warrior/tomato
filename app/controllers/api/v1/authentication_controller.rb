class Api::V1::AuthenticationController < ApiController
  before_action :authenticate_user_token, only: :logout
  
  def login
    if valid_user?
      tasks = @user.tasks
      render json: { user_id: @user.id, message: 'ok', auth_token: @user.auth_token, tasks: tasks}, status: 200
    else
      render json: { message: 'invalid user email or password' }, status: 401
    end
  end

  def logout
    current_user.regenerate_auth_token
    render json: { message: 'you have logged out' }, status: 200
  end

  private

  def valid_user?
    @user = User.find_by(email: params[:email])
    retuen false if @user.blank?
    # devise提供valid_password?方法
    @user.valid_password?(params[:password])
  end

end