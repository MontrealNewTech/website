# frozen_string_literal: true
module GoogleCalendar
  class EventConversion
    def call(google_calendar_event)
      events = if multi_day? google_calendar_event
                 create_one_event_per_day_from google_calendar_event
               else
                 create_with params_for google_calendar_event
               end

      errors = []

      ServiceResponse.new(events, errors.none?, errors)
    end

    private

    def multi_day?(google_calendar_event)
      start_of(google_calendar_event).to_date != end_of(google_calendar_event).to_date
    end

    def create_one_event_per_day_from(google_calendar_event)
      [
        create_with(params_for_first_day_of(google_calendar_event)),
        *all_day_events_in_between(google_calendar_event),
        create_with(params_for_last_day_of(google_calendar_event))
      ]
    end

    def create_with(arguments)
      ::Event.new(**arguments)
    end

    def start_of(google_calendar_event)
      (google_calendar_event.start.date_time || google_calendar_event.start.date).to_datetime
    end

    def end_of(google_calendar_event)
      (google_calendar_event.end.date_time || google_calendar_event.end.date).to_datetime
    end

    def date_range_of(google_calendar_event)
      (start_of(google_calendar_event).to_date..end_of(google_calendar_event).to_date).to_a
    end

    def params_for(google_calendar_event)
      {
        title: google_calendar_event.summary,
        start_at: google_calendar_event.start.date_time,
        end_at: google_calendar_event.end.date_time,
        description: google_calendar_event.description,
        location: google_calendar_event.location,
        link: google_calendar_event.html_link
      }
    end

    def params_for_first_day_of(multi_day_event)
      params_for(multi_day_event).merge end_at: start_of(multi_day_event).to_time.end_of_day
    end

    def params_for_last_day_of(multi_day_event)
      params_for(multi_day_event).merge start_at: end_of(multi_day_event).to_time.beginning_of_day
    end

    def all_day_events_in_between(google_calendar_event)
      middle_dates(google_calendar_event).map do |date|
        ::AllDayEvent.new(**params_for(google_calendar_event).
                          merge(start_at: date.to_datetime,
                                end_at: date.to_datetime))
      end
    end

    def middle_dates(event)
      date_range_of(event).tap do |range|
        range.shift
        range.pop
      end
    end
  end
end
