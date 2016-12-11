require 'rails_helper'

RSpec.describe GoogleCalendarEventFetcher do
  describe '#all_events' do
    let(:date) { Date.current }

    subject { described_class.new(date).events_calendar }

    describe 'setting up and fetching events from googles api' do
      let(:new_calendar) { instance_double EventsCalendar, build: true }
      let(:events) { double 'events', items: [] }
      let(:calendar_service) { instance_double Google::Apis::CalendarV3::CalendarService, :key= => true, list_events: events }

      before do
        allow(EventsCalendar).to receive(:new).with(an_instance_of(Array), an_instance_of(Range)).and_return new_calendar
        allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
      end

      it 'creates a google api client' do
        subject
        expect(Google::Apis::CalendarV3::CalendarService).to have_received :new
      end

      it 'sets the api key on the google calendar service' do
        subject
        expect(calendar_service).to have_received(:key=).with ENV['GOOGLE_CALENDAR_API_KEY']
      end

      it 'calls the google api to fetch the events' do
        subject
        expect(calendar_service).to have_received :list_events
      end

      it 'sends the expected params to the calendar service' do
        calendar_params = [
          APP_CONFIG[:community_cal_id],
          single_events: true,
          order_by: 'startTime',
          time_min: date.beginning_of_week(:sunday).beginning_of_day.iso8601,
          time_max: date.end_of_week(:sunday).end_of_day.iso8601
        ]

        subject
        expect(calendar_service).to have_received(:list_events).with(*calendar_params)
      end
    end

    describe 'cleaning up google calendar events' do
      GoogleCalendarEvent = Struct.new :summary, :start, :description, :location
      GoogleDate = Struct.new :date_time

      before do
        allow(EventsCalendar).to receive(:new).with(an_instance_of(Array), an_instance_of(Range)).and_return new_calendar
        allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
      end

      let(:time) { Time.parse('2016-12-11 12:22') }
      let(:fake_calendar_items) do
        (1..3).map do |n|
          GoogleCalendarEvent.new 'Whoo summary', GoogleDate.new(time), "Event ##{n}", 'An address'
        end
      end

      let(:new_calendar) { instance_double EventsCalendar, build: true }
      let(:events) { double 'events', items: fake_calendar_items }
      let(:calendar_service) { instance_double Google::Apis::CalendarV3::CalendarService, :key= => true, list_events: events }

      it 'converts the google event format into the right one for this app exactly once per calendar item' do
        expected_params = { title: 'Whoo summary',
                            start_at: time,
                            description: /Event #/,
                            location: 'An address' }
        expect(CommunityEvent).to receive(:new).with(expected_params).exactly(3).times
        subject
      end

      it 'builds a new calendar with these events' do
        subject
        expect(new_calendar).to have_received(:build)
      end
    end

    describe 'actually calling the google api' do
      before do
        stub_request(:get, /https:\/\/www.googleapis.com\/calendar\/v3\/calendars/).to_rack(FakeGoogleCalendars)
      end

      it 'makes an http request to the actual google api' do
        expect(subject.keys).to eq Date.parse('2016-12-12').all_week(:sunday).to_a
        expect(subject.values.flatten.map(&:class).uniq).to match_array [EmptyCalendarDayEvent, CommunityEvent]
        expect(subject.size).to eq 7
      end
    end
  end
end
