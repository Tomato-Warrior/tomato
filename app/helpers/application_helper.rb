module ApplicationHelper
  def expect_time(project)
    tictac_hour = project.tasks.sum(:expect_tictacs) * 1500.0 / 3600
    tictac_hour.round(tictac_hour % 10 == 0 ? 0 : 1)
  end
end
