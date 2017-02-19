# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PartnershipsController do
  describe 'GET #index' do
    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end

    it 'fetches all the partnerships' do
      expect(Partnership).to receive(:all)
      subject
    end
  end
end
