# frozen_string_literal: true
require 'rails_helper'

RSpec.describe InitiativesController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end
  end

  describe 'GET #show' do
    let(:initiative) { build_stubbed :initiative }

    subject { get :show, params: { id: initiative.to_param, locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end
  end
end
