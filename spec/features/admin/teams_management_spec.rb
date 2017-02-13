require 'rails_helper'

RSpec.feature 'managing teams' do
  before do
    admin = create :user, :admin
    login_as admin
  end

  scenario 'creating a new team' do
    visit admin_teams_path
    expect(page).to have_content 'Teams'

    click_on 'New team'

    fill_form_and_submit :team, name: 'New team',
                                description: 'Awesome team description.'

    expect(page).to have_css '.flash', text: 'Team was successfully created.'
  end

  scenario 'adding member profiles that already exist to a team' do
    team = create :team

    visit admin_member_profiles_path
    expect(page).to have_content 'Member Profiles'

    click_on 'New member profile'


  end

  # scenario 'creating a new member profile' do

  # end
end
