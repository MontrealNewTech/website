require 'icalendar'
require 'open-uri'

class IcalEvent
  GOOGLE_ICS = 'https://calendar.google.com/calendar/ical/4b3vms6i8vm26lvg69d7ncobec%40group.calendar.google.com/public/basic.ics'

  def initialize(ics = GOOGLE_ICS)
    @cal = Icalendar.parse(open(ics).read).first
  rescue *HTTP_ERRORS => error
    Rails.logger.warn error.message
    raise error
  end

  def upcoming_events
    @cal.events.select { |event| event.dtstart > Date.current }
  end
end
