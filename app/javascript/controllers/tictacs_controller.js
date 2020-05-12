import { Controller } from "stimulus"
import ax from "axios"

export default class extends Controller {
  static targets = [ "count" ]
  
  initialize(){
    this.clicked = false;
    const timeDisplay = document.querySelector('.display_time_left');
    const relaxbtn = document.querySelector('.relaxbtn')
    const startbtn = document.querySelector('.startbtn');
    let relax_num = 0

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
      const minutes = Math.floor(seconds / 60);
      const remainSeconds = seconds % 60;
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`;
      timeDisplay.textContent = display;
    }
  }
 
  start(e) {
    e.preventDefault();
    
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.startbtn');
    const stopbtn = document.querySelector(".stopbtn");
    const relaxbtn = document.querySelector(".relaxbtn")
    const seconds = startbtn.dataset.time
    let isRunning = true;
    let setCounter
    
    /*設定計時器*/ 
    let now = Date.now();
    let end_time = now + seconds * 1000;
    let secondsLeft = Math.round((end_time - Date.now()) / 1000);
    counter()

    function counter() {
        setCounter = setInterval(() =>{
        secondsLeft = Math.round((end_time - Date.now()) / 1000);
        displayTimeLeft(secondsLeft);    
        
        if (secondsLeft <= 0) {
          clearInterval(setCounter);
          isRunning = false
          window.alert("該休息了")
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
         
      },1000)
    }
    
    /*中止計時*/ 
    stopbtn.addEventListener('click', stop);


    function stop(){
      clearInterval(setCounter);
      const stopTime = Date.now()
      let check = confirm("確定要放棄番茄?")
      
      if (check){
        clearInterval(setCounter);
        isRunning = false;
        displayTimeLeft(seconds)
        stopbtn.removeEventListener('click',stop);
      }else{
        end_time += (Date.now() - stopTime) ;
        
        counter()
      }

    
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
    const relaxbtn = document.querySelector(".relaxbtn");
    const seconds = parseInt(relaxbtn.dataset.time);
    let isRunning = true;
    
    
    /*設定計時器*/ 
    const now = Date.now();
    const end_time = now + seconds * 1000;
    const setCounter = setInterval(() =>{
      const secondsLeft = Math.round((end_time - Date.now()) / 1000);
      displayTimeLeft(secondsLeft)    
      if (secondsLeft <= 0) {
        clearInterval(setCounter);
        isRunning = false
        window.alert("休息結束")
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
      ; 
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




 