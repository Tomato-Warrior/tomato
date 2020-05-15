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

  //sweetalert-alert_message
  autoCloseAlert(message){
    let timerInterval
    Swal.fire({
      title: message,
      timer: 2000,
      timerProgressBar: false
    })
  }

  //sweetalert-confirm drop or not
  confirmDropOrNot(){
    Swal.fire({
      title: '確定定要捨棄番茄嗎?',
      html: '請輸入原因',
      input: 'text',
      inputAttributes: {
        autocapitalize: 'off'
      },
      showCancelButton: true
    })
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
    let setCounter
    let that = this
    //設定計時器
    let now = Date.now()
    let end_time = now + seconds * 1000
    let secondsLeft = Math.round((end_time - now) / 1000)

    return new Promise(function(resolve, reject) {
      that.startbtnTarget.classList.add("d-none")
      that.stopbtnTarget.classList.remove("d-none")
      //=============================================變換時鐘顏色(進行)
      setCounter = setInterval(() => {
        secondsLeft = Math.round((end_time - Date.now()) / 1000)
        that.displayTimeLeft(secondsLeft)    
      
        if (secondsLeft <= 0) {
          clearInterval(setCounter)
          //===========================================提示聲音(工作結束)
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

          let check = prompt("確定要捨棄番茄嗎?","請輸入捨棄原因")
          
          if (check){
            clearInterval(setCounter);
            that.displayTimeLeft(seconds)
            that.stopbtnTarget.removeEventListener('click',stop)
            that.startbtnTarget.classList.remove("d-none")
            that.stopbtnTarget.classList.add("d-none")
            //==========================================提示聲音(放棄)
            //==========================================更換時鐘背景
            reject("stop~~")
          }else{ 
            end_time += (Date.now() - stopTime) 

            setCounter = setInterval(() => {
              secondsLeft = Math.round((end_time - Date.now()) / 1000)
              that.displayTimeLeft(secondsLeft)    
              
              if (secondsLeft <= 0) {
                clearInterval(setCounter)
                resolve("timeup")
                that.stopbtnTarget.removeEventListener('click', stop)
              }
            },1000)
          }
        })
      }
    })
  }

//計時結束
finishWorkApiPromise(){
  const tictac_id = this.stopbtnTarget.dataset.id
  return new Promise(function(resolve, reject) {
    Rails.ajax({
      url: `/api/v1/tictacs/${tictac_id}/finish`, 
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
  let setCounter
  let seconds = this.relaxbtnTarget.dataset.time
  let now = Date.now()
  let end_time = now + seconds * 1000
  let secondsLeft = Math.round((end_time - now) / 1000)
  let that = this
  

  return new Promise(function(resolve, reject) {
    that.relaxbtnTarget.classList.add("d-none")
    that.stopbtnTarget.classList.remove("d-none")
    //=================================================更換時鐘背景(進行)
    setCounter = setInterval(() =>{
      secondsLeft = Math.round((end_time - Date.now()) / 1000)
      that.displayTimeLeft(secondsLeft)    
    
      if (secondsLeft < 0) {
        clearInterval(setCounter)
        that.stopbtnTarget.removeEventListener('click', stop)  
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
          that.stopbtnTarget.removeEventListener('click', stop)
        })
      }
  })
  
}

// 中斷 api
breakWorkApiPromise(){
  const tictac_id = this.stopbtnTarget.dataset.id
  return new Promise(function(resolve, reject) {
    Rails.ajax({
      url: `/api/v1/tictacs/${tictac_id}/cancel`, 
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
      //============================================更換背景(工作->休息)
      //============================================更換時鐘背景(停止狀態)
      //============================================
      this.autoCloseAlert("休息一下~")
      this.displayTimeLeft(this.relaxbtnTarget.dataset.time)
    }).catch((data) => {
      console.log(data)
      return this.breakWorkApiPromise()
    }).then((data) => {
      console.log(data)
      

    })
  }

  relax(e){
    e.preventDefault()
    
    const seconds = parseInt(this.relaxbtnTarget.dataset.time)

    this.startRelaxPromise().then((data) => {
      console.log(data)
      this.stopbtnTarget.classList.add("d-none")
      this.startbtnTarget.classList.remove("d-none")
      this.autoCloseAlert("該開始下一顆番茄了")
      this.displayTimeLeft(this.startbtnTarget.dataset.time)
      //========================================================這裡要加提示聲音(休息的)
      //========================================================這裡要加更換背景(休息->工作)
      //========================================================更換時鐘背景(停止)
    }).catch((data) => {
      this.startbtnTarget.classList.remove("d-none")
      this.relaxbtnTarget.classList.add("d-none")
      this.stopbtnTarget.classList.add("d-none")
      this.autoCloseAlert("該開始下一顆番茄了")
      this.displayTimeLeft(this.startbtnTarget.dataset.time)
      //========================================================這裡要加提示聲音(休息的)
      //========================================================這裡要加更換背景(休息->工作)
      //========================================================更換時鐘背景(停止)
      
    })
  }

  stop(e){
    e.preventDefault();
  }
}




 