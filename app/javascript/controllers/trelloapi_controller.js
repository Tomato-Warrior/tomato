import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = []

  authenticationSuccess = function() {
    console.log('Successful authentication')
  }
  
  authenticationFailure = function() {
    console.log('Failed authentication')
  }

  connect(){
  }

  get(e){
    e.preventDefault()
    window.Trello.authorize({
      type: 'popup',
      name: 'Getting Started Application',
      scope: {
        read: 'true',
        write: 'true' },
      expiration: 'never',
      success: authenticationSuccess,
      error: authenticationFailure
    })
  }


}