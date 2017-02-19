# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Eventbrite::Event do
  include Stubs

  describe '.all' do
    subject { described_class.all }

    it 'fetches the events from eventbrite' do
      result = instance_double Eventbrite::Load, events: []
      allow(Eventbrite::Load).to receive(:new).and_return result
      subject
      expect(result).to have_received :events
    end

    describe 'calling the eventbrite api' do
      before do
        stub_eventbrite_events_call
        allow(Venue).to receive(:find).with(an_instance_of(Integer)).and_return true
      end

      it "creates an 'our event' for each event" do
        expect(Event).to receive(:new).exactly :once
        subject
      end

      it 'returns a collection of events' do
        expect(subject).to all be_a Event
      end

      it 'parses the eventbrite start and end times as local time' do
        expect(Time).to receive(:parse).exactly :twice
        subject
      end

      it 'fetches the event venue' do
        subject
        expect(Venue).to have_received(:find)
      end
    end
  end
end
