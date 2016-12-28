class Event < BaseEvent
  ATTRIBUTES = BaseEvent.members

  def self.ours
    Eventbrite::Event.all
  end

  def self.community(for_dates:)
    GoogleCalendar::Event.within(for_dates)
  end
end
