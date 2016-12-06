class EventsController < ApplicationController
  def index
    @events ||= GoogleCalendarEventFetcher.new.all_events
  end
end
