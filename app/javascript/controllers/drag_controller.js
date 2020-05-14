import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  
  static targets = ['message']

  connect() {
    this.sortable = Sortable.create(this.element, {
        onEnd: this.end.bind(this)
    })
  }
  end(e) {
      console.log(e)
  }
}