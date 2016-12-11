require 'rails_helper'

RSpec.describe NullDate do
  subject { described_class.new('events') }

  it { is_expected.to respond_to :strftime }

  describe '#strftime' do
    it 'returns a friendly message' do
      expect(subject.strftime('_anything')).to eq I18n.t('models.null_date.strftime', nullable: 'events')
    end
  end

  describe '#mon' do
    it "returns an arbitrary integer whose purpose I don't understand" do
      expect(subject.mon).to eq 1
    end
  end
end
