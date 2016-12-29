# frozen_string_literal: true
class Event < BaseEvent
  ATTRIBUTES = BaseEvent.members

  def self.ours
    Eventbrite::Event.all
  end

  def self.community(for_dates:)
    GoogleCalendar::Event.within(for_dates)
  end

  def display_time
    "#{I18n.l(start_at, format: :time)} - #{I18n.l(end_at, format: :time)}"
  end
end
