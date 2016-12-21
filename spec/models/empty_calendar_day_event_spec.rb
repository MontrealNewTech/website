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

  describe '#start_at' do
    it 'returns a null date that can be passed into a localization helper' do
      expect(subject.start_at).to be_a NullDate
    end
  end
end
