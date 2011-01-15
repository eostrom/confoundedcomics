jQuery(function($) {
  $('a.modal').nyroModal({
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

  $('#nyroModalContent a.cancel').live('click', function() {
    $.nyroModalRemove();
    return false;
  });

  $('#archive h2 a').click(function() {
    $('#archive #pages').show();
    return false;
  });
});
