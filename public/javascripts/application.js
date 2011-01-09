jQuery(function($) {
  $('a.modal').nyroModal({
    closeSelector: 'a.cancel',
    closeButton: ''
  });

  $('#archive h2 a').click(function() {
    $('#archive #pages').show();
    return false;
  });
});
