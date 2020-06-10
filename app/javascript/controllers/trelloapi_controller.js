import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {

  static targets = ["select_board", "select_card", "select_list", "change_list", "import_method", "call_options"]

  trello_token = ""
  api_key = "f91cef06b7d1a94754eac87835224aeb"
  
  trelloAuthorize = function() {
    let that = this
    return new Promise(function(resolve, reject){
      window.Trello.authorize({
        type: 'popup',
        name: 'TomaTokei',
        scope: {
          read: 'true',
          write: 'true' },
        expiration: 'never',
        success:  (data) => {
                        that.trello_token = localStorage.trello_token
                        resolve(data)
                        }
      })
    })
  }

  get_token(e){
    localStorage.clear()
    let that = this
    e.preventDefault()
    this.trelloAuthorize().then((data)=>{
      return new Promise(function(resolve, reject){
        (fetch(`https://api.trello.com/1/members/me?key=${that.api_key}&token=${that.trello_token}`, {
          method: 'GET',
          headers: {
            'Accept': 'application/json'
          }
        }))
          .then(response => {
          resolve(response.text())
          })
      }) 
    })
    .then((text) => {
      const submitData = {token: this.trello_token, data: text}
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
        }, 
        error: err => {
        } 
      })
    })   
  }

  select_board(e){
    let that = this
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
      }, 
      error: err => {
      } 
    })
    if (this.select_boardTarget.value != "none")
      that.import_methodTarget.classList.remove("d-none")
    else
      that.import_methodTarget.classList.add("d-none")
  } 


  call_options(e){
    const submitData = {task_id: this.change_listTarget.name}
    Rails.ajax({
      url: `/trelloapi/get_list_data`,
      type: 'POST', 
      dataType: 'json',
      beforeSend(xhr, options) {
        xhr.setRequestHeader('Content-Type', 'application/json; charset=UTF-8')
        options.data = JSON.stringify(submitData)
        return true
      },
      success: resp => {
        let data = resp.list_data
        let options = []
          for(let i=0;i<=data.length-1;i++){
            if(this.change_listTarget.value == data[i][1]){
              options.push(`<option value=${data[i][1]} selected>${data[i][0]}</option>`)
            }else{
              options.push(`<option value=${data[i][1]}>${data[i][0]}</option>`)
            }
          }
          this.change_listTarget.innerHTML=options.join("")
      }, 
      error: err => {
        console.log(err);
      } 
    })
  }

  change_list(){
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
      }
    })
    
  }
}