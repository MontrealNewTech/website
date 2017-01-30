# frozen_string_literal: true
module GoogleCalendar
  class EventConversion
    def call(google_calendar_event)
      events = if multi_day? google_calendar_event
                 create_one_event_per_day_from google_calendar_event
               else
                 [::Event.new(**params_for(google_calendar_event))]
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
        ::Event.new(**params_for_first_day_of(google_calendar_event)),
        *all_day_events_in_between(google_calendar_event),
        ::Event.new(**params_for_last_day_of(google_calendar_event))
      ]
      # create first day event with right time
      # create all middle-day events as full-day events
      # create last day event with right time
    end

    def create(event)
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

    def all_day_events_in_between(_google_calendar_event)
      []
      # TODO
    end
  end
end
