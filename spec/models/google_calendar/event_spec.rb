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

      before do
        allow(GoogleCalendar::Load).
          to receive(:new).
          with(dates).
          and_return calendar_load
      end

      let(:time) { Time.parse('2016-12-12-12:22') }
      let(:end_time) { Time.parse('2016-12-12-16:22') }
      let(:fake_calendar_items) do
        (1..3).map do |n|
          GoogleCalendarEvent.new 'Whoo summary',
                                   GoogleDate.new(time),
                                   GoogleDate.new(end_time),
                                   "Event ##{n}",
                                   'An address',
                                   'link'
        end
      end

      let(:calendar_load) { instance_double GoogleCalendar::Load, events: fake_calendar_items }

      it 'converts the google event format into the right one for this app exactly once per calendar item' do
        expected_params = {
          title: 'Whoo summary',
          start_at: time,
          end_at: end_time,
          description: /Event #/,
          location: 'An address',
          link: 'link'
        }
        expect(Event).to receive(:new).with(expected_params).exactly(3).times
        subject
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
