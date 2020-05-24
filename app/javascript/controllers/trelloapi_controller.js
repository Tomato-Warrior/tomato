import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["select_board", "select_card", "select_list"]
  trello_token = ""
  api_key = "f91cef06b7d1a94754eac87835224aeb"
  
  
  authenticationSuccess = function() {
    console.log('Successful authentication')
    
  }
  
  authenticationFailure = function() {
    console.log('Failed authentication')
  }
  trelloAuthorize = function() {
    let that = this
    return new Promise(function(resolve, reject){
      window.Trello.authorize({
        type: 'popup',
        name: 'start',
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
    this.trelloAuthorize()
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
    .then((text) => {
      const submitData = {token: this.trello_token, boards_data: text}
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
    .then((text) => {
      const submitData = {token: this.trello_token, boards_data: text}
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

  select_board(e){
    console.log(this.select_boardTarget.value)
    fetch(`https://api.trello.com/1/boards/${this.select_boardTarget.value}/cards?key=${this.api_key}&token=${this.trello_token}`, {
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
    .then((text) => {
      const submitData = {token: this.trello_token, cards_data: text}
      Rails.ajax({
        url: `/trelloapi/get_cards`, 
        type: 'POST', 
        dataType: 'json',
        beforeSend(xhr, options) {
          xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
          options.data = JSON.stringify(submitData)
          return true
        },
        success: resp => {
          console.log("get card!!!")
          console.log(resp)
          
        }, 
        error: err => {
          console.log(err);
        } 
      })
    })
    .catch(err => console.error(err))
    fetch(`https://api.trello.com/1/boards/${this.select_boardTarget.value}/lists?key=${this.api_key}&token=${this.trello_token}`, {
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
    .then((text) => {
      const submitData = {token: this.trello_token, lists_data: text}
      Rails.ajax({
        url: `/trelloapi/get_lists`, 
        type: 'POST', 
        dataType: 'json',
        beforeSend(xhr, options) {
          xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
          options.data = JSON.stringify(submitData)
          return true
        },
        success: resp => {
          console.log("get list!!!")
          console.log(resp)
          
        }, 
        error: err => {
          console.log(err);
        } 
      })
    })
    .catch(err => console.error(err))   
  } 
}