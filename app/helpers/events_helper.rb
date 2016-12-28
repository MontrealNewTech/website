module EventsHelper
  def external_link_for(event)
    return if event.link.nil?
    link_to event.link, event.link, target: '_blank', rel: 'nofollow'
  end
end
