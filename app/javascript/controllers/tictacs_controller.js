import { Controller } from "stimulus"
import Rails from "@rails/ujs"
export default class extends Controller {
  static targets = [ "count" ]
  
  initialize(){
    this.clicked = false
    const timeDisplay = document.querySelector('.display_time_left')
    const relaxbtn = document.querySelector('.relaxbtn')
    const startbtn = document.querySelector('.startbtn')
    let relax_num = 0

    //每4次休息
    relaxbtn.addEventListener("click", function(){
      relax_num += 1
      if (relax_num % 4 === 0){
        relaxbtn.dataset.time = "15"
      }else{
        relaxbtn.dataset.time = "5"
      }
    })

    displayTimeLeft(parseInt(startbtn.dataset.time))
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60)
      const remainSeconds = seconds % 60
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display
    }
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
    const timeDisplay = document.querySelector('.display_time_left')
    const startbtn = document.querySelector('.startbtn')
    const stopbtn = document.querySelector(".stopbtn")
    const seconds = startbtn.dataset.time
    let isRunning = true
    let setCounter
    
  //設定計時器
    let now = Date.now()
    let end_time = now + seconds * 1000
    let secondsLeft = Math.round((end_time - Date.now()) / 1000)

    return new Promise(function(resolve, reject) {
      startbtn.classList.add("d-none")
      stopbtn.classList.remove("d-none")

      setCounter = setInterval(() =>{
        secondsLeft = Math.round((end_time - Date.now()) / 1000)
        displayTimeLeft(secondsLeft)    
      
        if (secondsLeft <= 0) {
          clearInterval(setCounter)
          resolve("timeup")
        }
      },1000)
      //中斷事件
      stopbtn.addEventListener('click', stop)
      function stop () {
        return new Promise(function(yes, no) {
          clearInterval(setCounter);
          const stopTime = Date.now()
          let check = confirm("確定要放棄番茄?")
      
          if (check){
              clearInterval(setCounter);
              isRunning = false;
              displayTimeLeft(seconds)
              stopbtn.removeEventListener('click',stop)
              yes("")
          }else{
            end_time += (Date.now() - stopTime) 
            counter()
          }
        })
      }
    })
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60)
      const remainSeconds = seconds % 60
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display
    }
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
  const timeDisplay = document.querySelector('.display_time_left')
  const stopbtn = document.querySelector(".stopbtn")
  const relaxbtn = document.querySelector(".relaxbtn")
  const seconds = relaxbtn.dataset.time
  const BG = document.querySelector(".clock")
  let isRunning = true
  let setCounter
  let now = Date.now()
  let end_time = now + seconds * 1000
  let secondsLeft = Math.round((end_time - Date.now()) / 1000)
  let that = this

  return new Promise(function(resolve, reject) {
    relaxbtn.classList.add("d-none")
    stopbtn.classList.remove("d-none")
    setCounter = setInterval(() =>{
      secondsLeft = Math.round((end_time - Date.now()) / 1000)
      displayTimeLeft(secondsLeft)    
    
      if (secondsLeft < 0) {
        clearInterval(setCounter)
        resolve("relaxtime over")
      }
    },1000)
  })
  function displayTimeLeft(seconds) {
    const minutes = Math.floor(seconds / 60)
    const remainSeconds = seconds % 60
    const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
    timeDisplay.textContent = display
  }
}

  start(e) {
    e.preventDefault()
    
    const timeDisplay = document.querySelector('.display_time_left')
    const startbtn = document.querySelector('.startbtn')
    const stopbtn = document.querySelector(".stopbtn")
    const relaxbtn = document.querySelector(".relaxbtn")
    const seconds = startbtn.dataset.time
    const BG = document.querySelector(".clock")
    let isRunning = true
    let setCounter
   /*設定計時器*/ 
    let now = Date.now()
    let end_time = now + seconds * 1000
    let secondsLeft = Math.round((end_time - Date.now()) / 1000)

    this.startWorkApiPromise().then((data) => {
      console.log(data)
      return this.startWorkPromise()
    }).then((data) => {
      console.log(data)
      return this.finishWorkApiPromise()
    }).then((data) => {
      console.log(data)
      stopbtn.classList.add("d-none")
      relaxbtn.classList.remove("d-none")
      window.alert("休息一下~")
      displayTimeLeft(relaxbtn.dataset.time)
    })

    
    /*中止計時*/ 
    stopbtn.addEventListener('click', stop)

    function stop(){
      clearInterval(setCounter);
      const stopTime = Date.now()
      let check = confirm("確定要放棄番茄?")
      if (check){
        pressStopBtn.then((stopdata) => {
          console.log(stopdata)
          clearInterval(setCounter);
          isRunning = false;
          displayTimeLeft(seconds)
          stopbtn.removeEventListener('click',stop)
        })
      }else{
        end_time += (Date.now() - stopTime) 
        counter()
      }
    }
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60)
      const remainSeconds = seconds % 60
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display
    }
  }

  relax(e){
    e.preventDefault()
    
    const timeDisplay = document.querySelector('.display_time_left')
    const startbtn = document.querySelector('.startbtn')
    const stopbtn = document.querySelector(".stopbtn")
    const relaxbtn = document.querySelector(".relaxbtn")
    const seconds = parseInt(relaxbtn.dataset.time)
    const BG = document.querySelector(".clock")
    let isRunning = true
    const now = Date.now()
    const end_time = now + seconds * 1000

    this.startRelaxPromise().then((data) => {
      console.log(data)
      stopbtn.classList.add("d-none")
      startbtn.classList.remove("d-none")
      window.alert("該開始下一顆番茄了")
      displayTimeLeft(startbtn.dataset.time)
    })
 
    /*中止計時*/ 
    stopbtn.addEventListener('click', stop)

    function stop(){
      clearInterval(setCounter)
      displayTimeLeft(0)
      isRunning = false
      BG.style.backgroundColor = "red"
      stopbtn.removeEventListener('click',stop)
    }

    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60)
      const remainSeconds = seconds % 60
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display
    }

  }

  stop(e){
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left')
    const startbtn = document.querySelector('.startbtn')
    const stopbtn = document.querySelector(".stopbtn")
    let isRunning = false

    if (isRunning == false){
      stopbtn.classList.add("d-none")
      startbtn.classList.remove("d-none")
    }
  }
}




 