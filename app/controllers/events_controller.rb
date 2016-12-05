class EventsController < ApplicationController
  def index
    @events ||= IcalEvent.new.upcoming_events
  end
end
