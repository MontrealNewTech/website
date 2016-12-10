# frozen_string_literal: true
class EventsCalendar
  def initialize(events, dates)
    @events = events
    @dates = dates
  end

  def build
    fill_in events_grouped_by_date
  end

  private

  def events_grouped_by_date
    @events.group_by(&:start_at)
  end

  def fill_in(_events_by_date)
    events_grouped_by_date.reverse_merge empty_days
  end

  def empty_days
    Hash[@dates.map { |date| [date, [EmptyCalendarDayEvent.new]] }]
  end
end
