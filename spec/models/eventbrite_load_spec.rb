# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventbriteLoad do
  include Stubs

  describe '#events' do
    let(:expected_uri) { URI "#{EVENTBRITE[:api]}events/search/?organizer.id=#{EVENTBRITE[:organizer_id]}" }

    subject { described_class.new.events }

    describe "calling eventbrite's api" do
      before { stub_eventbrite_events_call }

      it 'creates a new get request for the right endpoint' do
        expect(Net::HTTP::Get).to receive(:new).with(expected_uri).and_call_original
        subject
      end

      it 'makes the api request' do
        expect(Net::HTTP).
          to receive(:start).
          with(expected_uri.hostname, expected_uri.port, use_ssl: true).
          and_call_original
        subject
      end

      it 'returns an array of open structs' do
        expect(subject).to be_an Array
        expect(subject).to all be_a OpenStruct
      end

      it 'caches the response with rails cache' do
        expect(Rails.cache).to receive :fetch
        subject
      end
    end
  end
end
