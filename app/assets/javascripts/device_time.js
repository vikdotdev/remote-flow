$(document).ready(function(){
  function setElementTime() {
    el.textContent = moment().format('HH:mm');
  }

  var el = document.getElementById('display-date');

  setElementTime();
  setInterval(function() {
    setElementTime();
  }, 1000);
});
