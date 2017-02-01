# frozen_string_literal: true
require 'google/apis/calendar_v3'

module GoogleCalendar
  class Event
    def self.within(range)
      new.within(range)
    end

    def within(range)
      extract_events_from fetched_events_for(range)
    end

    private

    def fetched_events_for(range)
      GoogleCalendar::Load.new(range).events
    end

    def extract_events_from(google_calendar_events)
      google_calendar_events.flat_map do |event|
        EventConversion.new.call(event).object
      end
    end
  end
end
