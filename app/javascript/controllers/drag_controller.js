import { Controller } from "stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs"

export default class extends Controller {

  static targets = [ "project_id" ]

  connect() {
    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }
  end(e) {
    let id = e.item.dataset.id;
    let data = new FormData();
    let project_id = this.project_idTarget.dataset.id
    data.append("position", e.newIndex + 1);

    Rails.ajax({
      url: `/projects/${project_id}/tasks/:id/drag`.replace(":id", id),
      type: 'PATCH',
      data: data
    })
  }
}