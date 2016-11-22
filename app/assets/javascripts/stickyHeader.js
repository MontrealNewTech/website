export default function stickyHeader() {
  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 250) {
      $('header').addClass('sticky')
      $('header').removeClass('transparent')
    }
    else {
      $('header').removeClass('sticky')
      $('header').addClass('transparent')
    }
  })
}
