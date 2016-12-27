# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventbriteFetcher do
  include Stubs

  describe '#our_events' do
    subject { described_class.new.call }

    it 'fetches the events from eventbrite' do
      result = instance_double EventbriteLoad, events: []
      allow(EventbriteLoad).to receive(:new).and_return result
      subject
      expect(result).to have_received :events
    end

    describe 'calling the eventbrite api' do
      before { stub_eventbrite_events_call }

      it "creates an 'our event' for each event" do
        expect(OurEvent).to receive(:new).exactly :once
        subject
      end

      it 'returns a collection of events' do
        expect(subject).to all be_a OurEvent
      end

      it 'parses the eventbrite start and end times as local time' do
        expect(Time).to receive(:parse).exactly :twice
        subject
      end
    end
  end
end
