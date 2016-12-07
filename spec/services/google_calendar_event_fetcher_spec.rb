require 'rails_helper'

RSpec.describe GoogleCalendarEventFetcher do
  describe '#all_events' do
    let(:events) { double 'events', items: true }

    subject { described_class.new(Date.current).all_events }

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

    it 'uses the beginning of the week for the time in the past to fetch' do

    end

    it 'uses the end of the week for the time in the future to fetch' do

    end

    it 'returns a list of google calendar event objects' do
      expect(subject).to all be_a Google::Apis::CalendarV3::Event
    end
  end
end
