class GoogleCalendarEventFetcher
  GOOGLE_CALENDAR_ENDPOINT = "https://content.googleapis.com/calendar/v3/calendars/#{APP_CONFIG[:community_cal_url]}/events?key=#{ENV['GOOGLE_CALENDAR_API_KEY']}"

  def all_events
    parse fetched_events
    binding.pry
  end

  private

  def fetched_events
    HTTParty.get(time_boxed_events).body
  end

  def time_boxed_events
    URI.encode(GOOGLE_CALENDAR_ENDPOINT + to_this_time_in_past + to_this_time_in_future)

    https://www.googleapis.com/calendar/v3/calendars/4b3vms6i8vm26lvg69d7ncobec%40group.calendar.google.com/events\?timeMax\=2016-06-03T10%3A00%3A00-05%3A00\&timeMin\=2016-01-03T10%3A00%3A00-05%3A00\&key\=AIzaSyA5vshXxfvhuNuIob8loRd6N2CjofGsqFk
  end

  def to_this_time_in_past
    "&timeMin=#{1.week.ago.to_datetime.rfc3339}"
  end

  def to_this_time_in_future
    "&timeMax=#{3.weeks.from_now.to_datetime.rfc3339}"
  end

  def parse(json)
    extract_events_from(json).items
  end

  def extract_events_from(json)
    JSON.parse(json, object_class: OpenStruct)
  end
end
