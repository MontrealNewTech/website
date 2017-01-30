# frozen_string_literal: true
RSpec.shared_context 'service response returning' do |class_name, expected_error_messages = []|
  it 'returns a valid service response' do
    expect(subject).to be_a ServiceResponse
  end

  context 'service response is successful' do
    before do
      allow_any_instance_of(ServiceResponse).to receive(:success?).and_return true
    end

    it 'returns a successful service response' do
      expect(subject.success?).to eq true
    end

    it 'returns the expected object type' do
      expect(subject.object).to be_a class_name
    end

    it 'returns any messages' do
      expect(subject.message).to eq expected_error_messages
    end
  end

  context 'service response fails' do
    before do
      allow_any_instance_of(ServiceResponse).to receive(:success?).and_return false
    end

    it 'returns a failing service response' do
      expect(subject.success?).to eq false
    end

    it 'returns the expected object type' do
      expect(subject.object).to be_a class_name
    end

    it 'returns any messges' do
      expect(subject.message).to eq expected_error_messages
    end
  end
end
