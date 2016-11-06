export default function smoothScroll() {
  (function (jQuery) {
    jQuery.mark = {
      jump: function (options) {
        let defaults = {
          selector: 'a.scroll-on-page'
        };
        if (typeof options == 'string') {
          defaults.selector = options;
        }

        options = jQuery.extend(defaults, options);
        return jQuery(options.selector).click(function (e) {
          let jumpobj = jQuery(this);
          let target = jumpobj.attr('href');
          let thespeed = 1000;
          let offset = jQuery(target).offset().top;
          jQuery('html,body').animate({
            scrollTop: offset
          }, thespeed, 'swing');
          e.preventDefault();
        });
      }
    };
  })(jQuery);

  jQuery(function(){
    jQuery.mark.jump();
  });
}
