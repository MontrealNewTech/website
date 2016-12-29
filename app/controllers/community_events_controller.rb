# frozen_string_literal: true
class CommunityEventsController < ApplicationController
  def index
    @date = from_param_or_today
    @events_by_date = EventsCalendar.new(community_events_this_week).build_week
  end

  private

  def from_param_or_today
    params[:date] ? Date.parse(params[:date]) : Date.current
  end

  def community_events_this_week
    Event.community(for_dates: @date.all_week(:sunday))
  end
end
