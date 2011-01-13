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

  $('#nyroModalWrapper form')
    .live('ajax:success', function(event, data, status, xhr) {
      $('#content').replaceWith(data);
      $.nyroModalRemove();
    })
    .live('ajax:error', function(event, xhr, status, error) {
      var newForm = $(xhr.responseText).replaceAll($(this));
      // var newForm = $(this).replaceWith(xhr.responseText);
      $.nyroModalSettings({height: newForm.height()});
    });

  $('#archive h2 a').click(function() {
    $('#archive #pages').show();
    return false;
  });
});
