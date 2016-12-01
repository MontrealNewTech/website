require 'rails_helper'

RSpec.describe InitiativesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/initiatives').to route_to('initiatives#index')
    end

    it 'routes to #show' do
      expect(get: '/initiatives/1').to route_to('initiatives#show', id: '1')
    end
  end
end
