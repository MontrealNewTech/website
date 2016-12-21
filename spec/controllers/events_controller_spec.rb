# frozen_string_literal: true
require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:calendar) { instance_double GoogleCalendarEventFetcher, events_calendar: true }

  before { allow(GoogleCalendarEventFetcher).to receive(:new).with(Date.current).and_return calendar }

  describe 'GET #index' do
    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end

    it 'fetches the events from google' do
      subject
      expect(calendar).to have_received(:events_calendar)
    end
  end
end
