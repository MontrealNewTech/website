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
      meta_info_for(event).
        merge(times_for(event)).
        merge(venue_for(event))
    end

    def meta_info_for(event)
      {
        description: event.description.html.html_safe,
        link: event.url,
        title: event.name.text,
        cover_image_url: event.logo&.original&.url
      }
    end

    def times_for(event)
      {
        end_at: Time.parse(event.end.local),
        start_at: Time.parse(event.start.local)
      }
    end

    def venue_for(event)
      {
        location: Venue.find(event.venue_id.to_i)
      }
    end
  end
end
