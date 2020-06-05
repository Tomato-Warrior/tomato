class ApiController < ActionController::API

  def authenticate_user_token
    user = User.find_by(auth_token: params['auth_token'])
    return render(json: { message: 'invalid token' }, status: 401) if user.nil?
    # 不存user session
    sign_in(user, store: false)
  end

end