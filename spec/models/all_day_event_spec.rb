# frozen_string_literal: true
require 'rails_helper'

RSpec.describe AllDayEvent do
  subject do
    described_class.new(start_at: Time.current,
                        end_at: 3.days.from_now)
  end

  it { is_expected.to respond_to(*Event::ATTRIBUTES) }

  describe 'default methods' do
    it 'defaults everything to nil' do
      Event::ATTRIBUTES.each do |method|
        expect(described_class.new.public_send(method)).to eq nil
      end
    end
  end

  describe '#display_time' do
    it 'shows the event is all day with its start and end dates' do
      start = l(subject.start_at, format: :date_time)
      finish = l(subject.end_at, format: :date_time)
      expect(subject.display_time).to eq t('all_day_event', start: start, finish: finish)
    end
  end
end
