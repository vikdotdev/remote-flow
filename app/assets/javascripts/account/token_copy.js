$(document).ready(function () {
  var inputEl = $("#deviceToken");
  var btnEl = $("#copyBtn");

  if (!inputEl || !btnEl) return;

  inputEl.click(function() {
    inputEl.select();
  });

  btnEl.click(function () {
    inputEl.select();
    document.execCommand('copy');
  });
});
