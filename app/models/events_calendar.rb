# frozen_string_literal: true
class EventsCalendar
  def initialize(events)
    @events = events
  end

  def build_week
    events_grouped_by_date.reverse_merge empty_days
  end

  private

  def events_grouped_by_date
    @events.group_by { |event| event.start_at.to_date }
  end

  def empty_days
    Hash[dates.map { |date| [date, [EmptyCalendarDayEvent.new]] }]
  end

  def dates
    sorted_events.first.start_at.to_date.all_week :sunday
  end

  def sorted_events
    @events.sort_by { |event| event.start_at.to_date }
  end
end
