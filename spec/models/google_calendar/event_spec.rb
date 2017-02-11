# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GoogleCalendar::Event do
  describe '#all_events' do
    let(:dates) { Date.parse('2016-12-12').all_week(:sunday) }

    subject { described_class.within(dates) }

    describe 'setting up and fetching events from googles api' do
      before do
        allow(GoogleCalendar::Load).to receive(:new).exactly(:once).and_return calendar_load
      end

      let(:calendar_load) { instance_double GoogleCalendar::Load, events: [] }

      it 'gets the events from a google calendar load' do
        subject
        expect(calendar_load).to have_received(:events).exactly :once
      end
    end

    describe 'cleaning up google calendar events' do
      GoogleCalendarEvent = Struct.new :summary, :start, :end, :description, :location, :html_link
      GoogleDate = Struct.new :date_time

      let(:time) { Time.parse('2016-12-12-12:22') }
      let(:calendar_load) { instance_double GoogleCalendar::Load, events: fake_calendar_items }

      before do
        allow(GoogleCalendar::Load).
          to receive(:new).
          with(dates).
          and_return calendar_load
      end

      context 'all events are single day events' do
        let(:fake_calendar_items) do
          (1..3).map do |n|
            GoogleCalendarEvent.new 'Whoo summary',
                                    GoogleDate.new(time),
                                    GoogleDate.new(time + 3.hours),
                                    "Event ##{n}",
                                    'An address',
                                    'link'
          end
        end

        let(:response) { instance_double ServiceResponse, object: true }
        let(:callable) { instance_double GoogleCalendar::EventConversion, call: response }

        before { allow(GoogleCalendar::EventConversion).to receive(:new).and_return callable }

        it 'creates an event conversion for each event' do
          expect(callable).
            to receive(:call).
            with(an_instance_of(GoogleCalendarEvent)).
            exactly(3).times
          subject
        end
      end

      context 'some events are more than one day long' do
        let(:event_count) { 2 }
        let(:fake_calendar_items) do
          Array.new(event_count) do |n|
            GoogleCalendarEvent.new 'Whoo summary',
                                    GoogleDate.new(time),
                                    GoogleDate.new(time + 3.days),
                                    "Event ##{n}",
                                    'An address',
                                    'link'
          end
        end

        it 'creates one event per day of a multi-day event' do
          expect(subject.count).to eq (time.to_date..(time + 3.days).to_date).count * event_count
        end
      end
    end

    describe 'actually calling the google api' do
      before do
        stub_request(:get, %r{https:\/\/www.googleapis.com\/calendar\/v3\/calendars}).
          to_rack(FakeGoogleCalendars)
      end

      it 'makes an http request to the actual google api and returns an expected response' do
        expect(subject).to all be_a Event
        expect(subject.size).to eq 16
      end
    end
  end
end
