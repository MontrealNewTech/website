require 'rails_helper'

RSpec.feature 'localization of db records' do
  before do
    admin = create :user, :admin
    login_as admin
  end

  scenario 'adding translations for an initiative' do
    visit admin_initiatives_path
    expect(page).to have_content 'Initiatives'

    click_on 'New initiative'

    fill_form_and_submit :initiative, 'English title' => 'New initiative',
                                      'English description' => 'Awesome initiative description.',
                                      'French title' => 'Un initiative',
                                      'French description' => "Ceci c'est le Francais"

    expect(page).to have_css '.flash', text: 'Initiative was successfully created.'

    visit initiatives_path
    expect(page).to have_content 'New initiative'
    expect(page).to have_content 'Awesome initiative description.'
    expect(page).not_to have_content 'Un initiative'
    expect(page).not_to have_content "Ceci c'est le Francais"

    I18n.locale = :fr
    visit initiatives_path
    expect(page).to have_content 'Un initiative'
    expect(page).to have_content "Ceci c'est le Francais"
    expect(page).not_to have_content 'New initiative'
    expect(page).not_to have_content 'Awesome initiative description.'
  end

  scenario 'adding translations for a member profile' do
    team = create :team

    visit admin_member_profiles_path
    expect(page).to have_content 'Member Profiles'

    click_on 'New member profile'

    find(:xpath, "//input[@id='member_profile_team_id-selectized']/..").click
    find(:xpath, "//div[@class='selectize-dropdown-content']/..", text: team.name).click

    fill_form_and_submit :member_profile, 'Name' => "Person's Name",
                                          'English position' => 'A position at MTL New Tech',
                                          'English bio' => 'Awesome member profile bio goes here',
                                          'French position' => "Ceci c'est le Francais",
                                          'French bio' => "Description a propos de quelqu'un"

    expect(page).to have_css '.flash', text: 'MemberProfile was successfully created.'

    visit about_path
    expect(page).to have_content 'A position at MTL New Tech'
    expect(page).to have_content 'Awesome member profile bio goes here'
    expect(page).not_to have_content "Ceci c'est le Francais"
    expect(page).not_to have_content "Description a propos de quelqu'un"

    I18n.locale = :fr
    visit about_path
    expect(page).to have_content "Ceci c'est le Francais"
    expect(page).to have_content "Description a propos de quelqu'un"
    expect(page).not_to have_content 'A position at MTL New Tech'
    expect(page).not_to have_content 'Awesome member profile bio goes here'
  end

  scenario 'adding translations for a team' do
    visit admin_teams_path
    expect(page).to have_content 'Teams'

    click_on 'New team'

    fill_form_and_submit :team, 'English name' => 'New team',
                                'English description' => 'Awesome team description.',
                                'French name' => 'Un equipe',
                                'French description' => "Ceci c'est le Francais"

    expect(page).to have_css '.flash', text: 'Team was successfully created.'

    visit about_path
    expect(page).to have_content 'New team'
    expect(page).to have_content 'Awesome team description.'
    expect(page).not_to have_content 'Un equipe'
    expect(page).not_to have_content "Ceci c'est le Francais"

    I18n.locale = :fr
    visit about_path
    expect(page).to have_content 'Un equipe'
    expect(page).to have_content "Ceci c'est le Francais"
    expect(page).not_to have_content 'New team'
    expect(page).not_to have_content 'Awesome team description.'
  end
end
