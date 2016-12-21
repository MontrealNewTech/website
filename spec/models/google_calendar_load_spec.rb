require 'rails_helper'

RSpec.describe GoogleCalendarLoad do
  let(:from) { Date.current.beginning_of_week(:sunday) }
  let(:to) { Date.current.end_of_week(:sunday) }

  subject { described_class.new(from, to).response }

  describe '#response' do
    let(:events) { double 'events', items: [] }
    let(:calendar_service) { instance_double Google::Apis::CalendarV3::CalendarService, :key= => true, list_events: events }

    before do
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

    it 'sends the expected params to the calendar service' do
      calendar_params = [
        APP_CONFIG[:community_cal_id],
        single_events: true,
        order_by: 'startTime',
        time_min: from.beginning_of_day.iso8601,
        time_max: to.end_of_day.iso8601
      ]

      subject
      expect(calendar_service).to have_received(:list_events).with(*calendar_params)
    end

    it 'caches the response with rails cache' do
      expect(Rails.cache).to receive :fetch
      subject
    end
  end

  describe 'actually calling the google api' do
    before do
      stub_request(:get, /https:\/\/www.googleapis.com\/calendar\/v3\/calendars/).to_rack(FakeGoogleCalendars)
    end

    it 'makes an http request to the actual google api' do
      expect(subject.items).to all be_a Google::Apis::CalendarV3::Event
      expect(subject.items.size).to eq 16
    end
  end
end
