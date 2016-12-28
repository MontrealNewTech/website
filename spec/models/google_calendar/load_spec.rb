# frozen_string_literal: true
require 'rails_helper'

RSpec.describe GoogleCalendar::Load do
  let(:dates) { Date.current.all_week(:sunday) }

  subject { described_class.new(dates).events }

  describe '#response' do
    let(:events) { double 'events', items: [] }
    let(:calendar_service) do
      instance_double Google::Apis::CalendarV3::CalendarService,
                      :key= => true,
                      list_events: events
    end

    before do
      allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
    end

    it 'creates a google api client' do
      subject
      expect(Google::Apis::CalendarV3::CalendarService).to have_received(:new).exactly :once
    end

    it 'sets the api key on the google calendar service' do
      subject
      expect(calendar_service).to have_received(:key=).with(ENV['GOOGLE_CALENDAR_API_KEY']).exactly :once
    end

    it 'sends the expected params to the calendar service' do
      calendar_params = [
        COMMUNITY_CALENDAR[:id],
        single_events: true,
        order_by: 'startTime',
        time_min: dates.begin.beginning_of_day.iso8601,
        time_max: dates.end.end_of_day.iso8601
      ]

      subject
      expect(calendar_service).to have_received(:list_events).with(*calendar_params).exactly :once
    end

    it 'caches the response with rails cache' do
      expect(Rails.cache).to receive :fetch
      subject
    end
  end

  describe 'actually calling the google api' do
    before do
      stub_request(:get, %r{https:\/\/www.googleapis.com\/calendar\/v3\/calendars}).
        to_rack(FakeGoogleCalendars)
    end

    it 'makes an http request to the actual google api' do
      expect(subject).to all be_a Google::Apis::CalendarV3::Event
      expect(subject.size).to eq 16
    end
  end
end
