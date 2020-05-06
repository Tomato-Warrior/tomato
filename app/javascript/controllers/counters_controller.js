import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "count", "timerbtn" ]
  
  initialize(){
    this.clicked = false
  }
  count(e) {
    e.preventDefault();
    
    let countdown;
    const timeDisplay = document.querySelector('.display_time_left');
    const startbtn = document.querySelector('.starttimer')
    const relaxbtn = document.querySelector('.relaxtimer')
    const stopbtn = document.querySelector('.stoptimer')
    
    function counter(seconds) {
      clearInterval(countdown);
      const now = Date.now();
      const then = now + seconds * 1000;
      
      countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        if (secondsLeft <= 0 && status === "work") {
          clearInterval(countdown);
          relaxbtn.classList.remove("d-none")
          stopbtn.classList.add("d-none")
        }else if(secondsLeft <= 0 && status === "relax") {
          clearInterval(countdown)
          startbtn.classList.remove("d-none")
          stopbtn.classList.add("d-none")
        }
        displayTimeLeft(secondsLeft);
      }, 1000);
    }

    function displayTimeLeft(seconds) {
      const minutes = Math.floor(seconds / 60);
      const remainSeconds = seconds % 60;
      const display = `${minutes}:${remainSeconds < 10 ? 0 : ''}${remainSeconds}`
      timeDisplay.textContent = display;
    }


    startbtn.addEventListener('click', function(){
      const seconds = parseInt(this.dataset.time);
      counter(seconds);
      status = "work"
    })
    relaxbtn.addEventListener('click', function(){
      const seconds = parseInt(this.dataset.time);
      counter(seconds);
      status = "relax"
    })

    stopbtn.addEventListener('click', function(){
      
      if (status === "work") {
        var check = confirm("確定要中斷番茄?")
      }else{
        var check = confirm("確定要中斷休息?")
      }
      
      if(check === true){
        const seconds = parseInt(this.dataset.time);
        counter(seconds);
        stopbtn.classList.add("d-none")
        if (status === "work") {
          startbtn.classList.add("d-none")
        }else if (status === "relax") {
          relaxbtn.classList.add("d-none")
        }
      }else{
        return
      }
      
    })
    if (status === "work") {
      startbtn.classList.add("d-none")
      stopbtn.classList.remove("d-none")
    }else if (status === "relax") {
      relaxbtn.classList.add("d-none")
      stopbtn.classList.remove("d-none")
    }
  }
}
