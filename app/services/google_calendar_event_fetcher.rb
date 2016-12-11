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
    authorized_service.list_events(APP_CONFIG[:community_cal_id],
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: from.beginning_of_day.iso8601,
                                   time_max: to.end_of_day.iso8601)
  end

  def from
    @date.beginning_of_week(:sunday)
  end

  def to
    @date.end_of_week(:sunday)
  end

  def authorized_service
    client.tap do |service|
      service.key = ENV['GOOGLE_CALENDAR_API_KEY']
    end
  end

  def client
    Google::Apis::CalendarV3::CalendarService.new
  end

  def extract_events_from(calendar)
    build_calendar_for cleaned_up_events_from(calendar.items)
  end

  def cleaned_up_events_from(google_calendar_events)
    google_calendar_events.map { |event| CommunityEvent.new(**params_for(event)) }
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
