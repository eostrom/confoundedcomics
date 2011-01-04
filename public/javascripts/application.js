jQuery(function($) {
  $('a.modal').nyroModal();

  $('#archive h2 a').click(function() {
    $('#archive #pages').show();
    return false;
  });
});
