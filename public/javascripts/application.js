jQuery(function($) {
  $('a.modal').nyroModal({
    closeSelector: 'a.cancel',
    closeButton: '',

    endFillContent: function(modal, settings) {
      modal.wrapper.find('.formtastic li.date input')
        .datepicker({
          constrainInput: false,
          showOn: 'button',
          buttonImageOnly: true
        });
    }
  });

  $('#archive h2 a').click(function() {
    $('#archive #pages').show();
    return false;
  });
});
