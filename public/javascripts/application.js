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

  (function() {
    var flashes = $('.flashes').addClass('dismissable');

    var fadeout = function(timeout) {
      return function() {
        flashes.stop(true).fadeOut(timeout, function() {
          $('body')
            .unbind('mousemove', slowfade)
            .unbind('click', fastfade)
          ;
        });
      };
    }

    var slowfade = fadeout(3000), fastfade = fadeout(200);
    var stopevent = function() { return false; };

    $('body')
      .mousemove(slowfade)
      .click(fastfade);

    flashes
      .mousemove(stopevent)
      .click(stopevent)
      .mouseover(function() {
        $(this).stop(true).animate({opacity: 1}, {duration: 2000});
      });
  })();
});
