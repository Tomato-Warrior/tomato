import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "count" ]
  
  initialize(){
    this.clicked = false;
  }
 
  start(e) {
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn")
    const seconds = parseInt(startbtn.dataset.time);
    const now = Date.now();
    const then = now + seconds * 1000;
    let isRunning = true

    /*設定計時器*/ 
    let counter = setInterval(() =>{
      const secondsLeft = Math.round((then - Date.now()) / 1000);
      
      if (secondsLeft < 0) {
        clearInterval(countdown);
      }
      displayTimeLeft(secondsLeft); 
    },1000)

    /*按鈕顯示*/ 
    if (isRunning == true){
      startbtn.classList.add("d-none")
      stopbtn.classList.remove("d-none")
    }

    /*中止計時*/ 
    stopbtn.addEventListener('click', stop)


    function stop(){
      clearInterval(counter)
      displayTimeLeft(0)
      console.log("stop")
      isRunning = false
      console.log(isRunning)
      stopbtn.removeEventListener('click',stop)
    }

    /*顯示時間*/
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60);
      const remainSeconds = seconds % 60;
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display;
    }
  }


  stop(e){
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn")
    const seconds = parseInt(startbtn.dataset.time);
    const now = Date.now();
    const then = now + seconds * 1000;
    let isRunning = false



    /*按鈕顯示*/ 
    if (isRunning == false){
      stopbtn.classList.add("d-none")
      startbtn.classList.remove("d-none")
    }
  }
}