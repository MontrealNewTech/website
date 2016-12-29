# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'visiting the home page' do
  include Stubs

  scenario 'as a guest' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call
    visit root_path

    expect(page).to have_link 'About',       href: about_path(locale: 'en')
    expect(page).to have_link 'Initiatives', href: initiatives_path(locale: 'en')
    expect(page).to have_link 'Events',      href: '#events'
  end

  scenario 'visiting in french' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call
    visit root_path(locale: 'fr')

    expect(page).to have_link 'About',       href: about_path(locale: 'fr')
    expect(page).to have_link 'Initiatives', href: initiatives_path(locale: 'fr')
    expect(page).to have_link 'Events',      href: '#events'
  end
end
