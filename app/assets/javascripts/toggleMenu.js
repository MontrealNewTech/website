export default function toggleMenu() {
  var menuToggle = $('.menu-toggle').unbind()
  $('#toggle_menu').removeClass('show');

  menuToggle.on('click', function(e) {
    e.preventDefault()
    $('#toggle_menu').slideToggle(function() {
      if($('#toggle_menu').is(':hidden')) {
        $('#toggle_menu').removeAttr('style')
      }
    })
  })
}
