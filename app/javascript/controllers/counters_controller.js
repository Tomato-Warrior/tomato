import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "count", "timerbtn" ]
  
  initialize(){
    this.clicked = false;
  }
  count(e) {
    e.preventDefault();
    
    let countdown;
    const timeDisplay = document.querySelector('.display_time_left');
    const buttons = document.querySelectorAll('[data-time]');

    function counter(seconds, status="work") {
      clearInterval(countdown);
      const now = Date.now();
      const then = now + seconds * 1000;
      
      countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        if (secondsLeft <= 0 && status === "work") {
          clearInterval(countdown);
          relaxTime()
        }else if(secondsLeft < 0 && status === "relax") {
          clearInterval(countdown)
        }else if(secondsLeft < 0 && status === "stop"){
          clearInterval(countdown)
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
    function startCounter() {
      const seconds = parseInt(this.dataset.time);
      counter(seconds);
    }
  
    buttons.forEach(button => button.addEventListener('click', function() {
         $(i)
    }));
    function relaxTime() {
      counter(300,"relax")
    }
    function start() {
      startCounter
      startbtn = document.querySelector('a .fa-play-circle')
      startbtn.classList.remove('fa-play-circle');
      startbtn.classList.add('fa-stop-circle');
    }
    function stop(){
      startbtn = document.querySelector('a .fa-stop-circle')
      startbtn.classList.remove('fa-stop-circle');
      startbtn.classList.add('fa-play-circle');
      if  (window.confirm("Do you really want to stop?")) { 
          counter(0, "stop")
      }
    }
  }
}
