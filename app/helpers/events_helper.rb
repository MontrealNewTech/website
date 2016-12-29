# frozen_string_literal: true
module EventsHelper
  def external_link_for(event)
    return if event.link.nil?
    link_to t('go_to_event'), event.link, target: '_blank', rel: 'nofollow', class: 'new-tab fixed-width-icon'
  end

  def eventbrite_ticket_link(event)
    "#{event.link}#tickets"
  end
end
