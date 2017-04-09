# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'collecting email addresses from the home page' do
  include Stubs

  scenario 'someone submits a valid email' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call

    visit root_path

    fill_in 'Your email address', with: 'valid@email.com'
    new_window = window_opened_by { click_button 'Keep me posted' }

    within_window new_window do
      expect(page).to have_content 'Subscribe to MTL NewTech'
    end
  end

  scenario 'someone submits an invalid email' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call

    visit root_path
    fill_in 'Your email address', with: 'invalidemail'

    new_window = window_opened_by { click_button 'Keep me posted' }

    within_window new_window do
      expect(page).to have_content 'Subscribe to MTL NewTech'
    end
  end
end
