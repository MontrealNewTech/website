# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommunityEventsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/calendar').to route_to('community_events#index', locale: 'en')
    end
  end
end
