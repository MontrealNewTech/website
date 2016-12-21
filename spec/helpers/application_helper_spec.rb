# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'full_title' do
    context 'page has a title' do
      it 'displays the full title' do
        expect(full_title('Dashboard')).to eq 'Dashboard | MTL New Tech'
      end
    end

    context 'page does not have a title' do
      it 'displays the right title' do
        expect(full_title(' ')).to eq 'MTL New Tech'
      end
    end
  end

  describe '#show_error' do
    it 'returns the content tag for an object that has errors' do
      object = build :contact, email: 'invalid@email'
      object.valid?

      expect(show_error(object, :email)).
        to eq '<p class="field-error">Looks like that&#39;s not a valid email address. Could you double check it?</p>'
    end

    it 'returns nothing for an object that has no errors' do
      object = build :contact, email: 'valid@email.com'
      object.valid?

      expect(show_error(object, :name)).to eq nil
    end
  end
end
