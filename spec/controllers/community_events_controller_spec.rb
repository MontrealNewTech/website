# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CommunityEventsController, type: :controller do
  let(:calendar) { instance_double EventsCalendar, build_for: true }

  before do
    events = double 'events'
    allow(Event).to receive(:community).with(for_dates: an_instance_of(Range)).and_return events
    allow(EventsCalendar).to receive(:new).with(events).and_return calendar
  end

  describe 'GET #index' do
    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end

    it 'fetches the events from google' do
      subject
      expect(calendar).to have_received(:build_for).with(an_instance_of Range)
    end
  end
end
