class ChartsController < ApplicationController
  def index
    @today_tictac = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).count

    @week_tictac = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).count

    @month_tictac = current_user.tictacs.finished.where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month).count
    
    @daily_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count
    
    @weekly_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count

    @monthly_tictac = current_user.tictacs.group(:status).group_by_day(:end_at).count

    @tasks = current_user.tasks

    tags = current_user.tags
    tag_arr = []
    tags.each do |tag|
      tag_arr << tag
    end
    @tags = tag_arr.uniq

  end
end