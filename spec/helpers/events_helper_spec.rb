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
end
