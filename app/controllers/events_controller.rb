class EventsController < ApplicationController
  def index
    @date = from_param_or_today
    @events_by_date = group_by_date(calendar_events).merge(empty_day)
  end

  private

  def group_by_date(events)
    events.group_by { |event| event.start.date_time.to_date }
  end

  def calendar_events
    GoogleCalendarEventFetcher.new(@date).all_events
  end

  def from_param_or_today
    params[:date] ? Date.parse(params[:date]) : Date.current
  end

  def empty_day
    { Date.parse("Sat, 10 Dec 2016") => [EventForEmptyDay.new] }
  end
end

# [
#     [0] :@access_role,
#     [1] :@default_reminders,
#     [2] :@description,
#     [3] :@etag,
#     [4] :@items,
#     [5] :@kind,
#     [6] :@summary,
#     [7] :@time_zone,
#     [8] :@updated
# ]
#
# [
#     [ 0] :@created,
#     [ 1] :@creator,
#     [ 2] :@end,
#     [ 3] :@etag,
#     [ 4] :@hangout_link,
#     [ 5] :@html_link,
#     [ 6] :@i_cal_uid,
#     [ 7] :@id,
#     [ 8] :@kind,
#     [ 9] :@location,
#     [10] :@organizer,
#     [11] :@original_start_time,
#     [12] :@recurring_event_id,
#     [13] :@sequence,
#     [14] :@start,
#     [15] :@status,
#     [16] :@summary,
#     [17] :@updated
# ]
