# frozen_string_literal: true
class EventbriteFetcher
  def call
    extract_events_from eventbrite_events
  end

  private

  def extract_events_from(event_structs)
    event_structs.map { |event| OurEvent.new(**params_for(event)) }
  end

  def eventbrite_events
    EventbriteLoad.new.events
  end

  def params_for(event)
    {
      description: event.description.html.html_safe,
      end_at: Time.parse(event.end.local),
      link: event.url,
      location: 'will get this later',
      start_at: Time.parse(event.start.local),
      title: event.name.text,
    }
  end
end
