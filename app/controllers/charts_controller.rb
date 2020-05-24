class ChartsController < ApplicationController
  def index
    @today_tictac = current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).count

    @week_tictac = current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).count

    @month_tictac = current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    
    @daily_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count
    
    @weekly_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count

    @monthly_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count
  end
end
