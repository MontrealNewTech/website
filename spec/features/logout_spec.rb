# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'loggout out after being logged in as an admin' do
  include Stubs

  scenario 'logging out from the admin sidebar' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call

    admin = create :user, :admin
    login_as admin

    visit admin_initiatives_path

    click_link t('log_out')
    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path
  end

  scenario 'logging out from the admin sidebar' do
    stub_eventbrite_events_call
    stub_eventbrite_venue_call

    admin = create :user, :admin
    login_as admin

    visit root_path

    click_link t('log_out')
    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path
  end
end
