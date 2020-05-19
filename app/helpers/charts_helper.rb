module ChartsHelper
  def display_today_tictac
    current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day).count
  end

  def display_week_tictac
    current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).count
  end

  def display_month_tictac
    current_user.tictacs.where(status: "finished").where('end_at BETWEEN ? AND ?', Time.zone.now.beginning_of_week, Time.zone.now.end_of_week).count
  end
end
