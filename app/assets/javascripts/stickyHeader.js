export default function stickyHeader() {
  let scope = $('body[data-action="home"]')
  if (scope.length === 0) {
    return
  }
  $(window).on('scroll', function() {
    if ($(this).scrollTop() > 50) {
      $('header').addClass('sticky')
      $('header').addClass('shadow')
      $('header').removeClass('transparent')
    }
    else {
      $('header').removeClass('sticky')
      $('header').removeClass('shadow')
      $('header').addClass('transparent')
    }
  })
}
