# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GoogleCalendar::EventConversion do
  GoogleCalendarEvent = Struct.new :summary, :start, :end, :description, :location, :html_link
  GoogleDate = Struct.new :date_time

  let(:time) { Time.parse('2016-12-12-12:22') }

  describe '#call' do
    subject { described_class.new.call(event) }

    context 'event is only a single day' do
      let(:event) do
        GoogleCalendarEvent.new 'Whoo summary',
                                GoogleDate.new(time),
                                GoogleDate.new(time + 5.hours),
                                'Event',
                                'An address',
                                'link'
      end

      it_behaves_like 'service response returning', Array

      it 'creates a single event' do
        expect(subject.object.size).to eq 1
      end

      it 'converts the google calendar event to a domain-specific event' do
        expect(subject.object).to all be_a Event
      end

      it 'maps the google attributes to ones for this app' do
        expect(subject.object.first.title).to eq event.summary
        expect(subject.object.first.start_at).to eq time
      end
    end

    context 'event is a multi-day event' do
      let(:end_time) { time + 67.hours }

      let(:event) do
        GoogleCalendarEvent.new 'Whoo summary',
                                GoogleDate.new(time),
                                GoogleDate.new(end_time),
                                'Event',
                                'An address',
                                'link'
      end

      it_behaves_like 'service response returning', Array

      it 'creates one event per day of the event' do
        expect(subject.object.size).to eq 4
      end

      it 'returns event for the first and last days' do
        expect([subject.object.first, subject.object.last]).to all be_a Event
      end

      it 'returns all day events for the dates in between' do
        expected_all_day_events = subject.object - [subject.object.first, subject.object.last]
        expect(expected_all_day_events).to all be_a AllDayEvent
      end

      it 'puts the proper start time for the event on the first dat' do
        expect(subject.object.first.start_at).to eq time
      end

      it 'puts the proper end time for the event on the last day' do
        expect(subject.object.last.end_at).to eq end_time
      end
    end
  end
end
