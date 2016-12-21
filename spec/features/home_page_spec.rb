# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'visiting the home page' do
  scenario 'as a guest' do
    visit root_path

    expect(page).to have_link 'About',       href: about_path(locale: 'en')
    expect(page).to have_link 'Initiatives', href: initiatives_path(locale: 'en')
    expect(page).to have_link 'Events',      href: '#events'
  end

  scenario 'visiting in french' do
    visit root_path(locale: 'fr')

    expect(page).to have_link 'About',       href: about_path(locale: 'fr')
    expect(page).to have_link 'Initiatives', href: initiatives_path(locale: 'fr')
    expect(page).to have_link 'Events',      href: '#events'
  end
end
