# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventsCalendar do
  describe '#build_week' do
    let(:dates) { Date.parse('2017-01-25').all_week :sunday }

    subject { described_class.new(events).build_for(dates) }

    context 'there are no empty dates' do
      let(:events) do
        dates.map do |date|
          Event.new(start_at: date.to_time)
        end
      end

      it 'returns a hash with one key for the given dates, inclusive' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end
    end

    context 'there are dates with no events' do
      let(:events) do
        dates.map do |date|
          next if date.day.even?
          Event.new(start_at: date.to_time)
        end.compact
      end

      it 'fills in the missing dates with null events' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end

      it 'returns exactly one key-array pair per date in the given range' do
        event_types =  subject.values.map { |events| events.first.class.name }
        expected_types = (%w(EmptyCalendarDayEvent Event) * 4).first(7)
        expect(event_types).to eq expected_types
      end
    end

    context 'there are multiple events on the same date but starting at different times' do
      let(:events) do
        [5, 8, 10].map do |hour|
          Event.new(start_at: dates.first.to_time.change(hour: hour))
        end << Event.new(start_at: dates.first(2).last)
      end

      it 'fills in the missing dates with null events' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end

      it 'returns exactly one key-array pair per date in the given range' do
        event_types =  subject.values.map { |events| events.first.class.name }
        expected_types = ['Event'] * 2 + ['EmptyCalendarDayEvent'] * 5
        expect(event_types).to eq expected_types
      end
    end

    context 'there is a multi-day event that starts before the desired range but ends during it' do
      let(:events) do
        [Event.new(start_at: dates.first.to_time, end_at: dates.first),
         AllDayEvent.new(start_at: dates.first.beginning_of_day)]
      end

      it 'fills in the missing dates with null events and selects the right week' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end

      it 'returns exactly one key-array pair per date in the given range' do
        event_types =  subject.values.map { |events| events.first.class.name }
        expected_types = ['Event'] + ['EmptyCalendarDayEvent'] * 6
        expect(event_types).to eq expected_types
      end
    end
  end
end
