# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'managing admin users' do
  scenario 'making an existing user and admin' do
    user = create :user
    admin = create :user, :admin
    login_as admin

    visit admin_accounts_path
    expect(page).to have_content user.email

    find_all('.action-edit', text: t('administrate.actions.edit')).first.click
    expect(page).to have_content t('administrate.display.account', email: user.email)
    expect(page).to have_content 'No'

    select 'Yes', from: 'account[admin]'
    click_button 'Update Account'

    expect(page).to have_content t('flash.accounts.success')
    expect(current_path).to eq admin_accounts_path
  end
end
