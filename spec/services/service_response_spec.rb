# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ServiceResponse do
  let(:object) { double 'object' }

  describe '#success?' do
    context 'with an activerecord object' do
      it 'fails with errors on the object' do
        sample_errors = [double('some fake errors')]
        allow(object).to receive(:errors).and_return(sample_errors)
        expect(described_class.new(object).success?).to eq false
      end

      it 'is successful without errors on the object' do
        allow(object).to receive_message_chain(:errors).and_return([])
        expect(described_class.new(object).success?).to eq true
      end
    end

    context 'with a non active-record object' do
      it 'defaults to success' do
        expect(described_class.new(object).success?).to eq true
      end

      it 'allows overriding of success? even for activerecord models' do
        sample_active_record_model = double(:ar_model, errors: [])
        expect(described_class.new(sample_active_record_model, false).success?).to eq false
      end
    end

    it 'passes the message over' do
      message = 'The email and password did not match records'
      expect(described_class.new(object, false, message).message).to eq message
    end

    it 'uses provided success values' do
      expect(described_class.new(object, false).success?).to eq false
      expect(described_class.new(object, true).success?).to  eq true
    end
  end

  describe '#message' do
    it 'defaults to nil' do
      expect(described_class.new(object).message).to eq nil
    end
  end

  describe '#to_hash' do
    it 'returns a hash for awesome print' do
      message = 'something happened'
      expect(described_class.new(object, false, message).to_hash).to eq object: object,
                                                                        success?: false,
                                                                        message: message
    end
  end
end
