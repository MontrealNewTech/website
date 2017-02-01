# frozen_string_literal: true
class EventsCalendar
  def initialize(events)
    @events = events
  end

  def build_for(range)
    events_grouped_by_date_in(range).reverse_merge empty_days_in(range)
  end

  private

  def events_grouped_by_date_in(range)
    filtered_events(range).group_by { |event| event.start_at.to_date }
  end

  def empty_days_in(range)
    Hash[range.map { |date| [date, [EmptyCalendarDayEvent.new]] }]
  end

  def filtered_events(range)
    @events.reject { |event| !range.include?(event.start_at.to_date) }
  end
end
