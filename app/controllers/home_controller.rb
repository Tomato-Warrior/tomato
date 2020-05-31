class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @tictacs = current_user.tictacs.where(end_at: range).finished
    @undo_today_tasks = current_user.tasks.where(created_at: range).doing
    @done_today_tasks = current_user.tasks.where(created_at: range).done
    @task = Task.new

    #lists_data = GetLists.new.get_lists($board_id, ENV['TRELLO_DEVELOPER_PUBLIC_KEY'], $token)
    #@lists = JSON.parse(lists_data)
    #lists_name = @lists.map{|list| list.values_at("name")}.flatten
    #lists_id = @lists.map{|list| list.values_at("id")}.flatten
    #@name_id_chart = Hash[lists_name.zip(lists_id)]
  end

  def todo
    range = Time.zone.now.beginning_of_day..Time.zone.now.end_of_day
    @todo_tictacs = current_user.tictacs.where.not(end_at: range).finished
    @todo_undo_tasks = current_user.tasks.where.not(created_at: range).doing
    @todo_done_tasks = current_user.tasks.where.not(created_at: range).done
  end

end
