require 'rails_helper'

RSpec.describe OurEvent do
  it { is_expected.to be_an Event }

  describe '.all' do
    subject { described_class.all }

    it 'fetches all the events from eventbrite' do
      fetcher = instance_double EventbriteFetcher, call: true
      allow(EventbriteFetcher).to receive(:new).and_return fetcher
      subject
      expect(fetcher).to have_received :call
    end
  end
end
