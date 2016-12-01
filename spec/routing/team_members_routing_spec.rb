require 'rails_helper'

RSpec.describe TeamMembersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/team_members').to route_to('team_members#index')
    end
  end
end
