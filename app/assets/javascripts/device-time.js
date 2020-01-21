$(document).ready(function(){
  function updateDeviceTimeIndicator($el) {
    if ($el.length) {
      $el.text(moment().format('HH:mm'));
    }
  }

  var $time = $('#display-date');

  updateDeviceTimeIndicator($time);
  setInterval(updateDeviceTimeIndicator.bind(this, $time), 1000);
});
