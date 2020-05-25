import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {

  static targets = [ ]

  end(e) {
    let task_title = e.val();
    
    Rails.ajax({
      url: '/api/v1/tasks/task_tag',
      type: 'GET',
      data: {title: task_title}
    })
    console.log(task_title)
  }
}