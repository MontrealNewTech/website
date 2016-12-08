export default function smoothScroll() {
  (function (jQuery) {
    let scope = $('body[data-action="home"]')
    if (scope.length === 0) {
      return
    }
    jQuery.mark = {
      jump: function (options) {
        let defaults = {
          selector: 'a.scroll-on-page'
        };
        if (typeof options === 'string') {
          defaults.selector = options;
        }

        options = jQuery.extend(defaults, options);
        return jQuery(options.selector).click(function (e) {
          let jumpobj = jQuery(this);
          if (jumpobj.attr('href') === '/' || jumpobj.attr('href') === '/fr') {
            var target = "#"
            var offset = 0
            if ($('#toggle_menu').is(':visible') && $('.menu-toggle').is(':visible')) {
              $('#toggle_menu').slideToggle(function() {
                $('body > header').toggleClass('menu-open')
              })
            }
          }
          else {
            var target = jumpobj.attr('href');
            var offset = jQuery(target).offset().top;
            if ($('.menu-toggle').is(':visible')) {
              $('#toggle_menu').slideToggle(function() {
                $('body' > 'header').toggleClass('menu-open')
                if ($('#toggle_menu').is(':hidden')) {
                  $('#toggle_menu').removeAttr('style')
                }
              })
            }
          }
          let thespeed = 1000;
          jQuery('html,body').animate({
            scrollTop: offset
          }, thespeed, 'swing');
          e.preventDefault();
        });
      }
    };
  })(jQuery);

  jQuery(function(){
    let scope = $('body[data-action="home"]')
    if (scope.length === 0) {
      return
    }
    jQuery.mark.jump();
  });
}
