require 'rails_helper'

RSpec.feature 'managing teams' do
  scenario 'creating a new team' do
    admin = create :user, :admin
    login_as admin

    visit admin_teams_path
    expect(page).to have_content 'Teams'

    click_button 'New team'

    fill_form :team, name: 'New team',
                     description: 'Awesome team description.'

    expect(page).to have_content 'Team successfully created.'
  end

  scenario 'adding member profiles that already exist to a team' do

  end

  scenario 'creating a new member profile' do

  end
end
