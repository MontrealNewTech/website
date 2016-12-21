# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Event, type: :model do
  it { is_expected.to belong_to :location }

  it { is_expected.to validate_presence_of :name        }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to validate_presence_of :starts_at   }

  it { is_expected.to delegate_method(:name).to(:location).with_prefix }

  describe 'slugging' do
    it 'handles slugging events when slugs are taken' do
      event = create :event, name: 'Learn Ruby on Rails'
      expect(event.slug).to eq 'learn-ruby-on-rails'

      other_event = create :event, name: 'Learn Ruby on Rails', starts_at: Time.zone.parse('2017-01-25 18:00:00')
      expect(other_event.slug).to eq 'learn-ruby-on-rails-2017-01-25'

      location = create :location, name: 'A nice location'
      another_event = create :event, name: 'Learn Ruby on Rails',
                                     starts_at: Time.zone.parse('2017-01-25 18:00:00'),
                                     location: location
      expect(another_event.slug).to eq 'learn-ruby-on-rails-2017-01-25-a-nice-location'
    end
  end
end
