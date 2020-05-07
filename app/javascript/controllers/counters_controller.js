import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "count" ]
  
  initialize(){
    this.clicked = false;
  }
  count(e) {
    e.preventDefault();

    let countdown;
    const timeDisplay = document.querySelector('.display_time_left');
    const btn25 = document.querySelector('.btn25');
    const seconds = parseInt(btn25.dataset.time);
    counter(seconds);
    
    function counter(seconds, status="work") {
      clearInterval(countdown);
      const now = Date.now();
      const then = now + seconds * 1000;
      
      countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        if (secondsLeft <= 0 && status === "work") {
          clearInterval(countdown);
          relaxTime()
        } else if(secondsLeft < 0 && status === "relax") {
          clearInterval(countdown)
          return;
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
    function relaxTime() {
      counter(300,"relax")
    }
  }

  count5(e) {
    e.preventDefault();
    
    let countdown;
    const timeDisplay = document.querySelector('.display_time_left2');
    const btn5 = document.querySelector('.btn5');
    const seconds = parseInt(btn5.dataset.time);
    counter(seconds);

    function counter(seconds, status="work") {
      clearInterval(countdown);
      const now = Date.now();
      const then = now + seconds * 1000;
      
      countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        if (secondsLeft <= 0 && status === "work") {
          clearInterval(countdown);
          relaxTime()
        } else if(secondsLeft < 0 && status === "relax") {
          clearInterval(countdown)
          return;
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
    function relaxTime() {
      counter(300,"relax")
    }
  }
  change25Btn(e) {
    e.preventDefault
    const icon25 = document.querySelector('.icon25');
    if (icon25.classList.contains('fa-play-circle')) {
      icon25.classList.remove('fa-play-circle')
      icon25.classList.add('fa-stop-circle')
    } else {
      icon25.classList.remove('fa-stop-circle')
      icon25.classList.add('fa-play-circle') 
    }
  }
  change5Btn(e) {
    e.preventDefault
    const icon5 = document.querySelector('.icon5');
    if (icon5.classList.contains('fa-play-circle')) {
      icon5.classList.remove('fa-play-circle')
      icon5.classList.add('fa-stop-circle')
    } else {
      icon5.classList.remove('fa-stop-circle')
      icon5.classList.add('fa-play-circle') 
    }
  }
}
