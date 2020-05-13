import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["resp"]

  startBtn(evt) {
    evt.preventDefault();
    
    Rails.ajax({
      url: `/api/v1/tictacs/start`, 
      type: 'POST', 
      dataType: 'json',
      success: resp => {
        console.log(resp)
      }, 
      error: err => {
        console.log(err);
      } 
    })
  }

  cancelBtn(evt){
    evt.preventDefault();
    let tictac = evt.target.dataset.id

    Rails.ajax({
      url: `/api/v1/tictacs/${tictac}/cancel`, 
      type: 'POST', 
      dataType: 'json',
      success: resp => {
        console.log(resp)
      }, 
      error: err => {
        console.log(err);
      } 
    })
  }

  finishBtn(evt){
    evt.preventDefault();
    let tictac = evt.target.dataset.id

    Rails.ajax({
      url: `/api/v1/tictacs/${tictac}/finish`, 
      type: 'POST', 
      dataType: 'json',
      success: resp => {
        console.log(resp)
      }, 
      error: err => {
        console.log(err);
      } 
    })

  }



}
