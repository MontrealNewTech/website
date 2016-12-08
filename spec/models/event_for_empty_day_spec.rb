require 'rails_helper'

RSpec.describe EventForEmptyDay do
  it { is_expected.to respond_to :summary, :start, :location }

  describe '#summary' do
    it 'returns a friendly message about there being no events' do
      expect(described_class.new.summary).to eq I18n.t('events.empty_day')
    end
  end

  describe 'start' do
    it 'returns something that can respond to #date_time' do
      expect(described_class.new.start).to respond_to :date_time
    end
  end
end
