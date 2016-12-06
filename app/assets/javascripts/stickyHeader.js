export default function stickyHeader() {
  let scope = $('body[data-action="home"]')
  if (scope.length === 0) {
    return
  }
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
