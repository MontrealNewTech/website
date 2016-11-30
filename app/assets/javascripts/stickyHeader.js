export default function stickyHeader() {
  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 250) {
      $('header').addClass('sticky')
      $('header').removeClass('transparent')
      $('.logo').fadeIn()
    }
    else {
      $('header').removeClass('sticky')
      $('header').addClass('transparent')
      $('.logo').fadeOut()
    }
  })
}

// this also shows the large logo on medium screen. Would be nice to fade in the right logo depending on the screen size
