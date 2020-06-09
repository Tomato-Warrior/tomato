class Api::V1::UserController < ApplicationController
  def time_setting
    user = User.find(params[:id].to_i)
    user.update(time_setting: params[:user][:time_setting])
    redirect_to root_path
  end
end