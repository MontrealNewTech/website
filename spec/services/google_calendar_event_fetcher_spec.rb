require 'rails_helper'

RSpec.describe GoogleCalendarEventFetcher do
  describe '#all_events' do
    let(:events) { double 'events', items: true }
    let(:date) { Date.current }

    subject { described_class.new(date).all_events }

    it 'creates a google api client' do
      calendar_service = double 'service', :key= => true, list_events: events
      allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
      subject

      expect(Google::Apis::CalendarV3::CalendarService).to have_received :new
    end

    it 'sets the api key on the google calendar service' do
      calendar_service = double 'service', :key= => true, list_events: events
      allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
      subject

      expect(calendar_service).to have_received(:key=).with ENV['GOOGLE_CALENDAR_API_KEY']
    end

    it 'calls the google api to fetch the events' do
      calendar_service = double 'calendar_service', :key= => true, list_events: events
      allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
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

      calendar_service = double 'calendar_service', :key= => true, list_events: events
      allow(Google::Apis::CalendarV3::CalendarService).to receive(:new).and_return calendar_service
      subject

      expect(calendar_service).to have_received(:list_events).with(*calendar_params)
    end

    it 'returns a list of google calendar event objects' do
      expect(subject).to all be_a Google::Apis::CalendarV3::Event
    end
  end
end
