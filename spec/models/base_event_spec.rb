# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BaseEvent, type: :model do
  it { is_expected.to respond_to(*Event::ATTRIBUTES) }

  describe 'accessors' do
    let(:params) do
      {
        description: 'This is really going to be a great event',
        end_at: 5.days.from_now,
        link: 'http://123.com',
        location: 'Notman House',
        start_at: 1.day.from_now,
        title: 'A nice event title',
      }
    end

    it 'exposes getters for all of the initialization params' do
      Event::ATTRIBUTES.each do |method|
        expect(described_class.new(**params).public_send(method)).to eq params[method]
      end
    end
  end
end
