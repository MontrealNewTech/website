# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PagesController, type: :routing do
  describe 'routing' do
    context 'in English' do
      it 'routes root to #home' do
        expect(get: '/').to route_to('pages#home', locale: 'en')
      end

      it 'routes to #about' do
        expect(get: '/about').to route_to('pages#about', locale: 'en')
      end
    end

    context 'in French' do
      it 'routes root to #home' do
        expect(get: '/fr').to route_to('pages#home', locale: 'fr')
      end

      it 'routes to #about' do
        expect(get: '/fr/about').to route_to('pages#about', locale: 'fr')
      end
    end
  end
end
