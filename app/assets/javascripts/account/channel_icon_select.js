$(document).ready(function() {
  function formatState(state) {
    if (!state.id) return state.text;
    else return $(`
      <span>
        <img src='${state.id}' class='pl-50 pr-1 channel-icon-picker'/>
        ${state.text}
      </span>`
    );
  }

  $('.js-select2-channel-icon').select2({
    placeholder: '-- Select Icon --',
    width: '100%',
    templateResult: formatState
  });
});

