# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to respond_to(*EVENT_ATTRIBUTES) }

  describe 'accessors' do
    let(:params) do
      {
        title: 'A nice event title',
        start_at: 1.day.from_now,
        description: 'This is really going to be a great event',
        location: 'Notman House',
        link: 'http://123.com'
      }
    end

    it 'exposes getters for all of the initialization params' do
      EVENT_ATTRIBUTES.each do |method|
        expect(described_class.new(**params).public_send(method)).to eq params[method]
      end
    end
  end
end
