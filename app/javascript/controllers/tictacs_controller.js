import { Controller } from "stimulus"
import Rails from "@rails/ujs"
export default class extends Controller {
  static targets = [ "count", "startbtn", "stopbtn", "relaxbtn", "show_time_left" ]

  displayTimeLeft(seconds) {
    const minutes = Math.floor(seconds / 60)
    const remainSeconds = seconds % 60
    const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
    this.show_time_leftTarget.textContent = display
  }

  connect(){
    this.clicked = false
    let relax_num = 0

    //每4次休息一次長休息

    this.relaxbtnTarget.addEventListener("click", function(){
      relax_num += 1
      
      if (relax_num % 4 === 0){
        this.dataset.time = "15"
      }else{
        this.dataset.time = "5"
      }
    })

    //顯示時間
    this.displayTimeLeft(parseInt(this.startbtnTarget.dataset.time))
    
  }

  //開始api
  startWorkApiPromise(){
    let that = this
    return new Promise(function(resolve, reject) {
      Rails.ajax({
        url: `/api/v1/tictacs/start`, 
        type: 'POST', 
        dataType: 'json',
        success: resp => {
          resolve(resp)
        }, 
        error: err => {
          console.log(err);
        } 
      })
    })
  }

  //開始計時
  startWorkPromise(){
    const seconds = this.startbtnTarget.dataset.time
    let isRunning = true
    let setCounter
    let that = this
  //設定計時器
    let now = Date.now()
    let end_time = now + seconds * 1000
    let secondsLeft = Math.round((end_time - now) / 1000)

    return new Promise(function(resolve, reject) {
      that.startbtnTarget.classList.add("d-none")
      that.stopbtnTarget.classList.remove("d-none")

      setCounter = setInterval(() => {
        secondsLeft = Math.round((end_time - Date.now()) / 1000)
        that.displayTimeLeft(secondsLeft)    
      
        if (secondsLeft <= 0) {
          clearInterval(setCounter)
          that.stopbtnTarget.removeEventListener('click',stop)
          resolve("timeup")
        }
      },1000)

      //中斷事件
      that.stopbtnTarget.addEventListener('click', stop)

      function stop () {
        return new Promise(function(yes, no) {
          clearInterval(setCounter);
          const stopTime = Date.now()
          let check = confirm("確定要放棄番茄?")
      
          if (check){
            clearInterval(setCounter);
            isRunning = false;
            that.displayTimeLeft(seconds)
            that.stopbtnTarget.removeEventListener('click',stop)
            startbtnTarget.classList.remove("d-none")
            stopbtnTarget.classList.add("d-none")
            reject("stop~~")
          }else{ 
            end_time += (Date.now() - stopTime) 

            setCounter = setInterval(() => {
              secondsLeft = Math.round((end_time - Date.now()) / 1000)
              that.displayTimeLeft(secondsLeft)    
            
              if (secondsLeft <= 0) {
                clearInterval(setCounter)
                resolve("return to work")
              }
            },1000)
          }
        })
      }
    })
    
  }

//計時結束
finishWorkApiPromise(){
  return new Promise(function(resolve, reject) {
    Rails.ajax({
      url: `/api/v1/tictacs/1/finish`, 
      type: 'POST', 
      dataType: 'json',
      success: resp => {
        resolve(resp)
      }, 
      error: err => {
        console.log(err);
      } 
    })
  }) 
}

//開始休息計時
startRelaxPromise(){
  let isRunning = true
  let setCounter
  let seconds = this.relaxbtnTarget.dataset.time
  let now = Date.now()
  let end_time = now + seconds * 1000
  let secondsLeft = Math.round((end_time - now) / 1000)
  let that = this
  

  return new Promise(function(resolve, reject) {
    that.relaxbtnTarget.classList.add("d-none")
    that.stopbtnTarget.classList.remove("d-none")
    setCounter = setInterval(() =>{
      secondsLeft = Math.round((end_time - Date.now()) / 1000)
      that.displayTimeLeft(secondsLeft)    
    
      if (secondsLeft < 0) {
        clearInterval(setCounter)
        resolve("relaxtime over")
      }
    },1000)

    //中斷事件
    that.stopbtnTarget.addEventListener('click', stop)

      function stop () {
        return new Promise(function(yes, no) {
          clearInterval(setCounter)
          that.displayTimeLeft(that.startbtnTarget.dataset.time)
          reject("relaxstop")
        })
      }
  })
  
}

// 中斷 api
breakWorkApiPromise(){
  return new Promise(function(resolve, reject) {
    Rails.ajax({
      url: `/api/v1/tictacs/1/cancel`, 
      type: 'POST', 
      dataType: 'json',
      success: resp => {
        resolve(resp)
      }, 
      error: err => {
        console.log(err);
      } 
    })
  }) 
}
  start(e) {
    e.preventDefault()
    
    const seconds = this.startbtnTarget.dataset.time
    let isRunning = true
    let setCounter
    /*設定計時器*/ 
    let now = Date.now()
    let end_time = now + seconds * 1000
    let secondsLeft = Math.round((end_time - now) / 1000)

    this.startWorkApiPromise().then((data) => {
      console.log(data)
      return this.startWorkPromise()
    }).then((data) => {
      console.log(data)
      return this.finishWorkApiPromise()
    }).then((data) => {
      console.log(data)
      this.stopbtnTarget.classList.add("d-none")
      this.relaxbtnTarget.classList.remove("d-none")
      window.alert("休息一下~")
      this.displayTimeLeft(this.relaxbtnTarget.dataset.time)
    }).catch((data) => {
      console.log(data)
      return this.breakWorkApiPromise()
    })
     
    
  }

  relax(e){
    e.preventDefault()
    
    const seconds = parseInt(this.relaxbtnTarget.dataset.time)


    this.startRelaxPromise().then((data) => {
      console.log(data)
      this.stopbtnTarget.classList.add("d-none")
      this.startbtnTarget.classList.remove("d-none")
      window.alert("該開始下一顆番茄了")
      this.displayTimeLeft(this.startbtnTarget.dataset.time)
    }).catch((data) => {
      this.startbtnTarget.classList.remove("d-none")
      this.relaxbtnTarget.classList.add("d-none")
      this.stopbtnTarget.classList.add("d-none")
      window.alert("該開始下一顆番茄了")
    })
 
    

    

    

  }

  stop(e){
    e.preventDefault();
    
    
  }
}




 