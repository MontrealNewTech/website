# frozen_string_literal: true
require 'google/apis/calendar_v3'

class GoogleCalendarEventFetcher
  def initialize(date)
    @date = date
  end

  def events_calendar
    extract_events_from fetched_calendar
  end

  private

  def fetched_calendar
    GoogleCalendarLoad.new(from, to).response
  end

  def from
    @date.beginning_of_week(:sunday)
  end

  def to
    @date.end_of_week(:sunday)
  end

  def extract_events_from(calendar)
    build_calendar_for cleaned_up_events_from(calendar.items)
  end

  def cleaned_up_events_from(google_calendar_events)
    google_calendar_events.map { |event| Event.new(**params_for(event)) }
  end

  def params_for(event)
    {
      title: event.summary,
      start_at: event.start.date_time,
      description: event.description,
      location: event.location
    }
  end

  def build_calendar_for(events)
    EventsCalendar.new(events, from..to).build
  end
end
