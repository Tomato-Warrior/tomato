import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
<<<<<<< HEAD
  static targets = ["select_board", "select_card", "select_list", "change_list"]
  trello_token = ""
  api_key = "f91cef06b7d1a94754eac87835224aeb"
  
  
  authenticationSuccess = function() {
    console.log('Successful authentication')
    
=======
  static targets = []
  trello_token = ""
  api_key = "f91cef06b7d1a94754eac87835224aeb"
  
  authenticationSuccess = function() {
    console.log('Successful authentication')
<<<<<<< HEAD
>>>>>>> datetimepicker problem
=======
    
>>>>>>> get client data
  }
  
  authenticationFailure = function() {
    console.log('Failed authentication')
  }
<<<<<<< HEAD
<<<<<<< HEAD
  trelloAuthorize = function() {
    let that = this
    return new Promise(function(resolve, reject){
      window.Trello.authorize({
        type: 'redirect',
        name: 'TomaTokei',
        scope: {
          read: 'true',
          write: 'true' },
        expiration: 'never',
        success:  (data) => {
                        that.authenticationSuccess()
                        that.trello_token = localStorage.trello_token
                        resolve(data)
                        },
        error: that.authenticationFailure
      })
    })
  }

  get_token(e){
    e.preventDefault()
    window.Trello.authorize({
      type: 'popup',
      name: 'start',
=======

  connect(){
  }

  get_token(e){
    e.preventDefault()
    window.Trello.authorize({
      type: 'popup',
      name: 'Getting Started Application',
>>>>>>> datetimepicker problem
=======
  trelloAuthorize = function() {
    window.Trello.authorize({
      type: 'popup',
      name: 'start',
>>>>>>> get client data
      scope: {
        read: 'true',
        write: 'true' },
      expiration: 'never',
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> get client data
      success:  () => {
                      this.authenticationSuccess()
                      this.trello_token = localStorage.trello_token
                      },
<<<<<<< HEAD
      error: this.authenticationFailure
    })
    .then((text) => {
      const submitData = {token: this.trello_token}
      Rails.ajax({
        url: `/trelloapi/get_boards`, 
        type: 'POST', 
        dataType: 'json',
        beforeSend(xhr, options) {
          xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
          options.data = JSON.stringify(submitData)
          return true
        },
        success: resp => {
          console.log(resp)
        }, 
        error: err => {
          console.log(err);
        } 
      })
    })
    .catch(err => console.error(err))    
    
  }

  connect(){
  }

  get_token(e){
    e.preventDefault()
    this.trelloAuthorize()
    fetch(`https://api.trello.com/1/members/me?key=${this.api_key}&token=${this.trello_token}`, {
      method: 'GET',
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => {
      console.log(
        `Response: ${response.status} ${response.statusText}`
      )
      return response.text();
    })
    .then((text) => {
      const submitData = {token: this.trello_token, boards_data: text}
      Rails.ajax({
        url: `/trelloapi/get_token`, 
        type: 'POST', 
        dataType: 'json',
        beforeSend(xhr, options) {
          xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
          options.data = JSON.stringify(submitData)
          return true
        },
        success: resp => {
          console.log(resp)
        }, 
        error: err => {
          console.log(err);
        } 
      })
    })
    .catch(err => console.error(err))    
  
  }

  select_board(e){
    const submitData = { board_id: this.select_boardTarget.value}
    Rails.ajax({
      url: `/trelloapi/get_board`, 
      type: 'POST', 
      dataType: 'json',
      beforeSend(xhr, options) {
        xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify(submitData)
        return true
      },
      success: resp => {
        console.log("get card!!!")   
      }, 
      error: err => {
        console.log(err);
      } 
    })
  } 
  change_list(){
    console.log("123")
    let list_id = this.change_listTarget.value
    let card_id = this.change_listTarget.id
    let task_id = this.change_listTarget.name
    const submitData = { list_id: list_id, card_id: card_id, task_id: task_id}
    Rails.ajax({
      url: `/trelloapi/change_list`, 
      type: 'POST', 
      dataType: 'json',
      beforeSend(xhr, options) {
        xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify(submitData)
        return true
      },
      success: resp => {
        console.log("get card!!!")   
      }, 
      error: err => {
        console.log(err);
      } 
    })
    fetch(`https://api.trello.com/1/cards/${card_id}?idList=${list_id}&key=${this.api_key}&token=${localStorage.trello_token}`, {
      method: 'PUT',
      headers: {
        'Accept': 'application/json'
      }
    })
    .then(response => {
      console.log(
        `Response: ${response.status} ${response.statusText}`
      );
      return response.text()
    })
    .then(text => console.log(text))
    .catch(err => console.error(err))

  }
=======
      success: authenticationSuccess,
      error: authenticationFailure
=======
      success: this.authenticationSuccess,
=======
>>>>>>> get client data
      error: this.authenticationFailure
>>>>>>> add client.js
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

>>>>>>> datetimepicker problem
}