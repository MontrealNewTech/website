# frozen_string_literal: true
module Eventbrite
  class Event
    def self.all
      new.our_events
    end

    def our_events
      extract_from eventbrite_events
    end

    private

    def extract_from(event_structs)
      event_structs.map { |event| ::Event.new(**params_for(event)) }
    end

    def eventbrite_events
      Eventbrite::Load.new.events
    end

    def params_for(event)
      {
        description: event.description.html.html_safe,
        end_at: Time.parse(event.end.local),
        link: event.url,
        location: Venue.find(event.venue_id.to_i),
        start_at: Time.parse(event.start.local),
        title: event.name.text,
      }
    end
  end
end
