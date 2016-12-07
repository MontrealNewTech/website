require 'google/apis/calendar_v3'

class GoogleCalendarEventFetcher
  def initialize(date)
    @date = date
  end

  def all_events
    extract_events_from fetched_calendar
  end

  private

  def fetched_calendar
    authorized_service.list_events(APP_CONFIG[:community_cal_id],
                                   single_events: true,
                                   order_by: 'startTime',
                                   time_min: from, #1.week.ago.iso8601,
                                   time_max: to #2.weeks.from_now.iso8601,)
                                  )
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
    calendar.items
  end

  def from
    @date.beginning_of_week(:sunday).beginning_of_day.iso8601
  end

  def to
    @date.end_of_week(:sunday).end_of_day.iso8601
  end
end
