(function() {
  var button = document.getElementById('new-content-dropdown-button');

  function fn() {
    var selectEl = document.getElementById('new-content-dropdown-select');
    button.href = selectEl.options[selectEl.selectedIndex].value
  }

  $('#new-content-dropdown-select').on('change', fn);
  $('#new-content-dropdown-select').ready(fn);
})()
