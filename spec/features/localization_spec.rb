require 'rails_helper'

RSpec.feature 'localization of db records' do
  before do
    admin = create :user, :admin
    login_as admin
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

    I18n.locale = :fr
    visit about_path
    expect(page).to have_content 'Un equipe'
    expect(page).to have_content "Ceci c'est le Francais"
  end
end
