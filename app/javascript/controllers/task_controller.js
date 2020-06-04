import { Controller } from "stimulus"

export default class extends Controller {
  
  static targets = ['title']

  submit(evt) {
    if (evt.keyCode == 13 && this.titleTarget.value == '' ){
      console.log('aaa');
      
    }
  }
}