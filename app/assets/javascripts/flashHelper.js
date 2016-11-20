export default function flashHelper() {
  $('.close').on('click', function() {
    $(this).parent().fadeOut()
  })

  setTimeout(function() {
    $('#flash').fadeOut()
  }, 3500)
}
