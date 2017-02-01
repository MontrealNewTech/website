# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AllDayDate do
  it { is_expected.to respond_to :strftime }

  describe '#strftime' do
    it 'returns all day for a time' do
      expect(subject.strftime('nothing')).to eq I18n.t('models.all_day_date.strftime')
    end
  end
end
