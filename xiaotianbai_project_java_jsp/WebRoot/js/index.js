

'use strict';

$(function() {

  function resize() {

    var windowWidth = $(window).width();

    var isSmallScreen = windowWidth < 768;

    $('#main_ad > .carousel-inner > .item').each(function(i, item) {

      var $item = $(item);

      var imgSrc =
        isSmallScreen ? $item.data('image-xs') : $item.data('image-lg');

      $item.css('backgroundImage', 'url("' + imgSrc + '")');

      if (isSmallScreen) {
        $item.html('<img src="' + imgSrc + '" alt="" />');
      } else {
        $item.empty();
      }
    });
  }

  $(window).on('resize', resize).trigger('resize');
   

  var $carousels = $('.carousel');
  var startX, endX;
  var offset = 50;

  $carousels.on('touchstart', function(e) {

    startX = e.originalEvent.touches[0].clientX;

  });

  $carousels.on('touchmove', function(e) {

    endX = e.originalEvent.touches[0].clientX;

  });
  $carousels.on('touchend', function(e) {
    console.log(e);

    var distance = Math.abs(startX - endX);
    if (distance > offset) {

      $(this).carousel(startX > endX ? 'next' : 'prev');
    }
  });
  
  
  
  
  /*click hide*/
  $('.navbar-collapse a').click(function(){
  	$(this).css("background","lightgreen");
      $('.navbar-collapse').collapse('hide');
  });
  new WOW().init();

});
