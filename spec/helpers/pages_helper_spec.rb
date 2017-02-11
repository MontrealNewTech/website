# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PagesHelper do
  describe '#events_nav_link' do
    context 'it is the home page' do
      before do
        allow(helper).to receive(:home_page?).and_return true
      end

      it 'returns a link to the events anchor with the right classes' do
        expect(helper.events_nav_link).to match(/#{t('layouts.header.events')}/)
        expect(helper.events_nav_link).to match(/#events/)
        expect(helper.events_nav_link).to match(/scroll-on-page button featured/)
      end
    end

    context 'it is the home page' do
      before do
        allow(helper).to receive(:home_page?).and_return false
      end

      it 'returns a link to the events anchor with the right classes' do
        expect(helper.events_nav_link).to match(/#{t('layouts.header.events')}/)
        expect(helper.events_nav_link).to match(/\/#events/)
        expect(helper.events_nav_link).to match(/button/)
      end
    end
  end

  describe '#home_page?' do
    context 'it is the home page' do
      before do
        allow(controller).to receive(:controller_name).and_return 'pages'
        allow(controller).to receive(:action_name).and_return 'home'
      end

      it 'returns true' do
        expect(helper.home_page?).to eq true
      end
    end

    context 'it is the home page' do
      before do
        allow(controller).to receive(:controller_name).and_return 'not_pages'
        allow(controller).to receive(:action_name).and_return 'not_home'
      end

      it 'returns false' do
        expect(helper.home_page?).to eq false
      end
    end
  end
end
