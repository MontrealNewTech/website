# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'restricting access to admin section' do
  scenario 'redirecting a user who is not an admin' do
    visit admin_initiatives_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'letting in a user who is an admin' do
    admin = create :user, :admin
    login_as admin

    visit admin_initiatives_path

    expect(current_path).to eq admin_initiatives_path
  end
end
