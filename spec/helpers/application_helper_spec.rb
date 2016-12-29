# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title' do
    context 'page has a title' do
      it 'displays the full title' do
        expect(full_title('Dashboard')).to eq 'Dashboard | Montreal Newtech'
      end
    end

    context 'page does not have a title' do
      it 'displays the right title' do
        expect(full_title(' ')).to eq 'Montreal Newtech'
      end
    end
  end

  describe '#show_error' do
    it 'returns the content tag for an object that has errors' do
      object = build :contact, email: 'invalid@email'
      object.valid?

      expect(show_error(object, :email)).
        to eq '<p class="field-error">Looks like that&#39;s not a valid email address. Could you double check it?</p>'
    end

    it 'returns nothing for an object that has no errors' do
      object = build :contact, email: 'valid@email.com'
      object.valid?

      expect(show_error(object, :name)).to eq nil
    end
  end

  describe '#google_search_link' do
    it 'returns a link to google maps searching for the given destination' do
      destination = '123 Place Ville Marie'
      expect(helper.google_search_link(destination)).
        to match Regexp.escape('https://www.google.com/maps/search/123+Place+Ville+Marie')
      expect(helper.google_search_link(destination)).
        to match(/#{destination}/)
      expect(helper.google_search_link(destination)).
        to match(/target="_blank"/)
    end
  end
end
