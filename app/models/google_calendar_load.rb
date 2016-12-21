# frozen_string_literal: true
require 'google/apis/calendar_v3'

class GoogleCalendarLoad
  def initialize(from, to)
    @from = from.beginning_of_day.iso8601
    @to   = to.end_of_day.iso8601
  end

  def response
    Rails.cache.fetch "google_community_calendar_events_from_#{@from}_to_#{@to}", expires_in: 10.minutes do
      authorized_service.list_events(APP_CONFIG[:community_cal_id],
                                     single_events: true,
                                     order_by: 'startTime',
                                     time_min: @from,
                                     time_max: @to)
    end
  end

  private

  def authorized_service
    client.tap do |service|
      service.key = ENV['GOOGLE_CALENDAR_API_KEY']
    end
  end

  def client
    Google::Apis::CalendarV3::CalendarService.new
  end
end
