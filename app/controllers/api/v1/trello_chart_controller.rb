class Api::V1::TrelloChartController < ApplicationController
  def trello_project_chart
    @project = current_user.projects.find(params[:id])
    @task_finished_finished = 0
    @task_cancelled_cancelled = 0
    trello_infos = []
    trello_tasks_id = []

    if @project.trello_board_id != nil
      trello_infos = TrelloInfo.where(board_id: @project.trello_board_id)

      trello_infos.each do |trello_info|
        trello_tasks_id << trello_info.task_id
        trello_tasks_id.uniq!
      end

      trello_tasks_id.each do |trello_task_id|
        @trello_task_arr = []
        trello_infos.each do |trello_info|
          if trello_info.task_id == trello_task_id
            if trello_info.task.tictacs.count != nil
              @task_finished_tictacs += trello_info.task.tictacs.finished.count
              @task_cancelled_tictacs += trello_info.task.tictacs.cancelled.count
              @task_status = trello_info.list_name
              @task_title = trello_info.task.title
              @trello_task_arr.push(@task_title, @task_finished_tictacs, @task_cancelled_tictacs, @task_status)    
              byebug

            end
          end
        end
      end

  

    end
   
    data = {
      "data": [
        [
          "Tiger Nixon",
          "System Architect",
          "Edinburgh",
          "$320,800"
        ],
        [
          "Garrett Winters",
          "Accountant",
          "Tokyo",
          "$170,750"
        ]
      ]
    }

    render json: data
  end
end