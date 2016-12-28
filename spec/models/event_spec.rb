require 'rails_helper'

RSpec.describe Event do
  describe '.ours' do
    subject { described_class.ours }

    it 'fetches all our events from eventbrite' do
      allow(Eventbrite::Event).to receive(:all).and_return []
      subject
      expect(Eventbrite::Event).to have_received(:all)
    end
  end

  describe '.community' do
    let(:range) { Date.current.all_week }

    subject { described_class.community(for_dates: range) }

    it 'fetches all our events from google' do
      allow(GoogleCalendar::Event).to receive(:within).with(range).and_return []
      subject
      expect(GoogleCalendar::Event).to have_received(:within).with(range)
    end
  end
end
