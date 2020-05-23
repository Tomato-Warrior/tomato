import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = []
  trello_token = ""
  api_key = "f91cef06b7d1a94754eac87835224aeb"
  
  authenticationSuccess = function() {
    console.log('Successful authentication')
    
  }
  
  authenticationFailure = function() {
    console.log('Failed authentication')
  }
  trelloAuthorize = function() {
    window.Trello.authorize({
      type: 'popup',
      name: 'start',
      scope: {
        read: 'true',
        write: 'true' },
      expiration: 'never',
      success:  () => {
                      this.authenticationSuccess()
                      this.trello_token = localStorage.trello_token
                      },
      error: this.authenticationFailure
    })
  }

  connect(){
  }

  get_token(e){
    e.preventDefault()
    this.trelloAuthorize() 
  }

  add_task(e){
    e.preventDefault()
    fetch(`https://api.trello.com/1/members/me/boards?key=${this.api_key}&token=${this.trello_token}`, {
      method: 'GET',
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => {
      console.log(
        `Response: ${response.status} ${response.statusText}`
      );
      return response.text();
    })
    .then(text => console.log(text))
    .catch(err => console.error(err));

  
    /*const boards = window.Trello.get('/members/me/boards');
    console.log(boards)
    console.log(boards)*/
    
  }

}