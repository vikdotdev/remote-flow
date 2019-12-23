$(document).ready(function() {
  $('.datepicker').daterangepicker({
    timePicker: true,
    timePicker24Hour: true,
    locale: {
      format: 'DD/MM/YYYY HH:mm'
    }
  });
});
