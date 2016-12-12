# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventsCalendar do
  describe '#build' do
    let(:dates) { Date.current.all_week }

    subject { described_class.new(events, dates).build }

    context 'there are no empty dates' do
      let(:events) do
        dates.map do |date|
          CommunityEvent.new(start_at: date.to_time)
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
          CommunityEvent.new(start_at: date.to_time)
        end.compact
      end

      it 'fills in the missing dates with null events' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end

      it 'returns exactly one key-array pair per date in the given range' do
        event_types =  subject.values.map { |events| events.first.class.name }
        expected_types = (%w(CommunityEvent EmptyCalendarDayEvent) * 4).first(7)
        expect(event_types).to eq expected_types
      end
    end

    context 'there are multiple events on the same date but starting at different times' do
      let(:events) do
        [5, 8, 10].map do |hour|
          CommunityEvent.new(start_at: dates.first.to_time.change(hour: hour))
        end
      end

      it 'fills in the missing dates with null events' do
        expect(subject.keys.count).to eq 7
        expect(subject.keys).to eq [*dates]
      end

      it 'returns exactly one key-array pair per date in the given range' do
        event_types =  subject.values.map { |events| events.first.class.name }
        expected_types = ['CommunityEvent'] + ['EmptyCalendarDayEvent'] * 6
        expect(event_types).to eq expected_types
      end
    end
  end
end
