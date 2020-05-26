import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
  static targets = ["select_board", "select_card", "select_list", "change_list"]
  trello_token = ""
  api_key = "trello_api_key"
  
  
  
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
      const submitData = {token: this.trello_token}
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
}