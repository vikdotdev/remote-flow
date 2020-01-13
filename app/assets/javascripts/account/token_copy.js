$(document).ready(function () {
  var $input = $("#deviceToken");
  var $button = $("#copyBtn");

  if (!$input.length || !$button.length) return;

  function inputSelect(_, copy) {
    $input.select();
    if (copy || false) document.execCommand('copy');
  }

  $input.on('click', inputSelect);
  $button.on('click', inputSelect.bind(this, {}, true));
});
