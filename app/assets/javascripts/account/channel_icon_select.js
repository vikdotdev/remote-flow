function formatState(state) {
  if (!state.id) {
    return state.text;
  }

  debugger
  var baseUrl = "/assets/channel_icons";
  var $state = $(
    '<span value="' + state.text.toUpperCase() + '"}><img src="' + baseUrl + '/' + state.text.toLowerCase() + '.svg" width="30px"/> ' + state.text + '</span>'
  );
  return $state;
};

$(document).ready(function() {
  $('.js-select2-channel-icon').select2({
    placeholder: '-- Select Icon --',
    width: '100%',
    templateResult: formatState
  });
});

