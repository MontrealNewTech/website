# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OurEventsController do
  describe '#index' do
    before { allow(OurEvent).to receive(:all).and_return [] }

    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end

    it 'loads all the events' do
      subject
      expect(OurEvent).to have_received(:all)
    end
  end
end