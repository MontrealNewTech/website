class EventsController < ApplicationController
  def index
    @date = from_param_or_today
    @events_by_date = GoogleCalendarEventFetcher.new(@date).events_calendar
  end

  private

  def from_param_or_today
    params[:date] ? Date.parse(params[:date]) : Date.current
  end
end
