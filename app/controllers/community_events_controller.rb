# frozen_string_literal: true
class CommunityEventsController < ApplicationController
  def index
    @date = from_param_or_today
    @events_by_date = EventsCalendar.new(community_events).build_for(range)
  end

  private

  def from_param_or_today
    params[:date] ? Date.parse(params[:date]) : Date.current.beginning_of_week(:sunday)
  end

  def community_events
    Event.community(for_dates: range)
  end

  def range
    @date.all_week(:sunday)
  end
end
