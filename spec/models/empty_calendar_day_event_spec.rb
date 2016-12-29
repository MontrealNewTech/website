# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EmptyCalendarDayEvent do
  it { is_expected.to respond_to(*Event::ATTRIBUTES) }

  describe 'default methods' do
    it 'defaults everything except start_at to nil' do
      (Event::ATTRIBUTES - [:start_at]).each do |method|
        expect(described_class.new.public_send(method)).to eq nil
      end
    end
  end

  describe '#display_time' do
    it 'returns a friendly message that there are not events on this date' do
      expect(subject.display_time).to eq I18n.t('no_events')
    end
  end
end
