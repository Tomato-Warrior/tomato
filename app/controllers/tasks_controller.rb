class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    def new
        @task = Task.new
    end
    def create
        @task = Task.new(task_params)

        if @task.save
            
            redirect_to counters_path, notice: "成功喵~任務新增成功"#flash[:notice] = "成功喵~餐點新增成功"
        else
            render :new
        end
    end







    private
    def task_params
        params.require(:task).permit(:task_name, 
                                    :description,
                                    :tomato_num,
                                    :task_date
                                    )
    end
    def find_task
        @task = Task.find(params[:id])
        #@item = Item.find_by!(id: params[:id], deleted_at: nil)
    end
end
