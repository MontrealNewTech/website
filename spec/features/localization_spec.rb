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

    I18n.locale = :fr
    visit initiatives_path
    expect(page).to have_content 'Un initiative'
    expect(page).to have_content "Ceci c'est le Francais"
  end

  scenario 'adding translations for a team' do
    visit admin_teams_path
    expect(page).to have_content 'Teams'

    click_on 'New team'

    fill_form_and_submit :team, 'English title' => 'New team',
                                'English description' => 'Awesome team description.',
                                'French title' => 'Un equipe',
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
