export default function toggleMenu() {
  let menuToggle = $('.menu-toggle').unbind()
  $('#toggle_menu').removeClass('show');

  menuToggle.on('click', function(e) {
    console.log("CLICK WORKED!!")
    e.preventDefault()
    $('#toggle_menu').slideToggle(function() {
      if($('#toggle_menu').is(':hidden')) {
        $('#toggle_menu').removeAttr('style')
      }
    })
  })
}
