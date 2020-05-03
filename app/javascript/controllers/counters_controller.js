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
    const buttons = document.querySelectorAll('[data-time]');

    function counter(seconds) {
      clearInterval(countdown);
      const now = Date.now();
      const then = now + seconds * 1000;
      
      countdown = setInterval(() => {
        const secondsLeft = Math.round((then - Date.now()) / 1000);

        if (secondsLeft < 0) {
          clearInterval(countdown);
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
    function startCounter() {
      const seconds = parseInt(this.dataset.time);
      counter(seconds);
    }
  
    buttons.forEach(button => button.addEventListener('click', startCounter));
  }
}
