import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "count" ]
  
  initialize(){
    this.clicked = false;
    const timeDisplay = document.querySelector('.display_time_left');
  }
 
  start(e) {
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn");
    const relaxbtn = document.querySelector(".relaxbtn")
    const seconds = 25
    let isRunning = true;
    
    
    /*設定計時器*/ 
    const now = Date.now();
    const end_time = now + seconds * 1000;
    const setCounter = setInterval(() =>{
      const secondsLeft = Math.round((end_time - Date.now()) / 1000);
          
      if (secondsLeft <= 0) {
        clearInterval(setCounter);
        isRunning = false
        relaxbtn.classList.remove("d-none")
      }
      /*按鈕顯示*/ 
      if (isRunning === true){
        startbtn.classList.add("d-none");
        stopbtn.classList.remove("d-none");
      }else if(isRunning === false && relaxbtn.classList.contains("d-none") === false){
        relaxbtn.classList.remove("d-none")
        stopbtn.classList.add("d-none")
      }else{
        startbtn.classList.remove("d-none");
        stopbtn.classList.add("d-none");
      }
      displayTimeLeft(secondsLeft); 
    },1000)
    
     



    /*中止計時*/ 
    stopbtn.addEventListener('click', stop);


    function stop(){
      clearInterval(setCounter);
      displayTimeLeft(0);
      isRunning = false;
      stopbtn.removeEventListener('click',stop);
    }

    /*顯示時間*/
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60);
      const remainSeconds = seconds % 60;
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`;
      timeDisplay.textContent = display;
    }
    
  }

  relax(e){
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn");
    const relaxbtn = document.querySelector(".relaxbtn")
    const seconds = 5
    let isRunning = true;
    
    
    /*設定計時器*/ 
    const now = Date.now();
    const end_time = now + seconds * 1000;
    const setCounter = setInterval(() =>{
      const secondsLeft = Math.round((end_time - Date.now()) / 1000);
          
      if (secondsLeft <= 0) {
        clearInterval(setCounter);
        isRunning = false
      }
      /*按鈕顯示*/ 
      if (isRunning == true){
        relaxbtn.classList.add("d-none");
        stopbtn.classList.remove("d-none");
      }else{
        startbtn.classList.remove("d-none")
        relaxbtn.classList.add("d-none")
        stopbtn.classList.add("d-none")
      }
      displayTimeLeft(secondsLeft); 
    },1000)
    
     



    /*中止計時*/ 
    stopbtn.addEventListener('click', stop);


    function stop(){
      clearInterval(setCounter);
      displayTimeLeft(0);
      isRunning = false;
      stopbtn.removeEventListener('click',stop);
    }

    /*顯示時間*/
    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60);
      const remainSeconds = seconds % 60;
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`;
      timeDisplay.textContent = display;
    }

  }

  stop(e){
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn")
    let isRunning = false;



    /*按鈕顯示*/ 
    if (isRunning == false){
      stopbtn.classList.add("d-none");
      startbtn.classList.remove("d-none");
    }
  }

  
}




 