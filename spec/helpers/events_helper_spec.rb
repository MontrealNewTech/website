# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventsHelper do
  describe '#external_link_for' do
    context 'event has no link' do
      let(:event) { Event.new }

      it 'returns nil' do
        expect(helper.external_link_for(event)).to eq nil
      end
    end

    context 'event has a link' do
      let(:event) { Event.new link: 'has a link' }

      it 'returns a link to the link' do
        expect(helper.external_link_for(event)).
          to eq '<a target="_blank" rel="nofollow" href="has a link">has a link</a>'
      end
    end
  end

  describe '#eventbrite_ticket_link' do
    it 'appends #tickets to the event link' do
      event = Event.new(link: 'link.com')
      expect(helper.eventbrite_ticket_link(event)).to eq 'link.com#tickets'
    end
  end
end
