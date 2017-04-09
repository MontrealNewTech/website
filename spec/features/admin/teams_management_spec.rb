# frozen_string_literal: true
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

    fill_form_and_submit :team, 'English name' => 'New team',
                                'English description' => 'Awesome team description.'

    expect(page).to have_css '.flash', text: 'Team was successfully created.'
  end

  scenario 'creating a new member profile' do
    team = create :team
    user = create :user

    visit admin_member_profiles_path
    expect(page).to have_content 'Member Profiles'

    click_on 'New member profile'

    find(:xpath, "//input[@id='member_profile_user_id-selectized']/..").click
    find(:xpath, "//div[@class='option']/..", text: user.email).click

    find(:xpath, "//input[@id='member_profile_team_id-selectized']/..").click
    find(:xpath, "//div[@class='selectize-dropdown-content']/..", text: team.name).click

    fill_form_and_submit :member_profile, name: "This User's Name",
                                          'English position' => 'Website Coordinator',
                                          'English bio' => 'Bio for this user'

    expect(page).to have_content 'MemberProfile was successfully created.'
  end

  scenario 'adding member profiles that already exist to a team' do
    team = create :team
    member_profile = create :member_profile, name: 'Joe'

    visit admin_teams_path
    expect(page).to have_content 'Teams'

    first('.action-edit', text: 'Edit').click

    find(:xpath, "//input[@id='team_member_profile_ids-selectized']/..").click
    find(:xpath, "//div[@class='selectize-dropdown-content']/..").click

    click_on 'Update Team'

    expect(page).to have_content 'Team was successfully updated.'
    expect(page).to have_link team.name
    expect(page).to have_content member_profile.name
    expect(page).to have_content member_profile.position
  end
end
