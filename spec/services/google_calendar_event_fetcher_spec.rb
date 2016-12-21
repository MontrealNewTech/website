# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GoogleCalendarEventFetcher do
  describe '#all_events' do
    let(:date) { Date.parse('2016-12-12') }

    subject { described_class.new(date).events_calendar }

    describe 'setting up and fetching events from googles api' do
      before do
        allow(GoogleCalendarLoad).to receive(:new).exactly(:once).and_return calendar_load
      end

      let(:calendar_load) { instance_double GoogleCalendarLoad, response: events }
      let(:events) { double 'events', items: [] }

      it 'gets the response from a google calendar load' do
        subject
        expect(calendar_load).to have_received(:response).exactly :once
      end
    end

    describe 'cleaning up google calendar events' do
      GoogleCalendarEvent = Struct.new :summary, :start, :description, :location
      GoogleDate = Struct.new :date_time

      before do
        allow(EventsCalendar).
          to receive(:new).
          with(an_instance_of(Array), an_instance_of(Range)).
          and_return new_calendar
        allow(GoogleCalendarLoad).
          to receive(:new).
          and_return calendar_load
      end

      let(:time) { Time.parse('2016-12-12-12:22') }
      let(:fake_calendar_items) do
        (1..3).map do |n|
          GoogleCalendarEvent.new 'Whoo summary', GoogleDate.new(time), "Event ##{n}", 'An address'
        end
      end

      let(:new_calendar) { instance_double EventsCalendar, build: true }
      let(:calendar_load) { instance_double GoogleCalendarLoad, response: events }
      let(:events) { double 'events', items: fake_calendar_items }

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
        stub_request(:get, %r{https:\/\/www.googleapis.com\/calendar\/v3\/calendars}).
          to_rack(FakeGoogleCalendars)
      end

      it 'makes an http request to the actual google api and returns an expected response' do
        expect(subject.keys).to eq Date.parse('2016-12-12').all_week(:sunday).to_a
        expect(subject.values.flatten.map(&:class).uniq).to match_array [EmptyCalendarDayEvent, CommunityEvent]
        expect(subject.size).to eq 7
      end
    end
  end
end
