import { Controller } from "stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs"

export default class extends Controller {
  
  static targets = []

  connect() {
    this.sortable = Sortable.create(this.element, {
        onEnd: this.end.bind(this)
    })
  }
  end(e) {
    let id = e.item.dataset.id;
    let data = new FormData();
    data.append("position", e.newIndex + 1);

    Rails.ajax({
        url: this.data.get("url").replace(":id", id),
        type: 'PATCH',
        data: data
    })
  }
}