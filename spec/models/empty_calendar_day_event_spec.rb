# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EmptyCalendarDayEvent do
  let(:date) { Date.current }

  subject { described_class.on(date) }

  it { is_expected.to respond_to(*Event::ATTRIBUTES) }

  describe '#title' do
    it 'returns a friendly message about there being no events' do
      expect(subject.title).to eq I18n.t('events.empty_day')
    end
  end

  describe 'start_at' do
    it 'returns the given date' do
      expect(subject.start_at).to eq date
    end
  end
end
