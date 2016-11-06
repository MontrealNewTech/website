require 'rails_helper'

RSpec.feature 'collecting email addresses from the home page', js: true do
  scenario 'someone submits a valid email' do
    allow_any_instance_of(ActionDispatch::Request).to receive(:remote_ip).and_return('1.2.3.4')
    visit root_path

    fill_form :contact, 'Your email address': 'valid@email.com'
    click_button 'Keep me posted'

    expect(page).to have_content 'Thanks for signing up!'
    expect(Contact.last.remote_ip).to eq '1.2.3.4'
  end

  scenario 'someone submits an invalid or duplicate email' do
    create :contact, email: 'an_email_we_already_have@gmail.com'

    visit root_path
    fill_form :contact, 'Your email address': 'invalid@email'
    click_button 'Keep me posted'

    expect(page).to have_content "Looks like that's not a valid email address. Could you double check it?"

    fill_form :contact, 'Your email address': 'an_email_we_already_have@gmail.com'
    click_button 'Keep me posted'

    expect(page).to have_content "Looks like you're already signed up! We have that email already."
  end
end

