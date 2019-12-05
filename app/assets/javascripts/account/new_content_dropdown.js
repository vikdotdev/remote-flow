(function() {
  var button = document.getElementById('new-content-dropdown-button');

  function fn() {
    var e = document.getElementById('new-content-dropdown-select');
    button.href = e.options[e.selectedIndex].value
  }

  $('#new-content-dropdown-select').on('change', fn);
  $('#new-content-dropdown-select').ready(fn);
})()
