module PagesHelper
  def events_nav_link
    return link_to t('layouts.header.events'), '#events', class: 'scroll-on-page featured' if home_page?
    link_to t('layouts.header.events'), our_events_path, class: 'button'
  end

  def home_page?
    controller.controller_name == 'pages' && controller.action_name == 'home'
  end
end