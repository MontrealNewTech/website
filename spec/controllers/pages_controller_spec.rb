require 'rails_helper'

RSpec.describe PagesController do
  describe 'GET #home' do
    before { allow(Event).to receive :ours }

    it 'loads out events' do
      get :home, params: { locale: I18n.locale.to_param }
      expect(Event).to have_received :ours
    end

    it 'loads all the sponsors' do
      expect(Organization).to receive :all
      get :home, params: { locale: I18n.locale.to_param }
    end
  end

  describe 'GET #about' do
    it 'loads all teams' do
      allow(Team).to receive(:all).and_call_original
      get :about, params: { locale: I18n.locale.to_param }
      expect(Team).to have_received(:all)
    end

    it 'pre-loads the member profiles' do
      expect(Team).to receive(:includes).with(:member_profiles)
      get :about, params: { locale: I18n.locale.to_param }
    end
  end
end
