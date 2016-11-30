require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def index
      render body: nil
    end
  end

  before do
    @routes.draw { get :index, controller: :anonymous }
  end

  describe '#default_url_options' do
    it 'always sends the I18n.locale in the params' do
      expect(controller.default_url_options).to eq locale: I18n.locale
    end
  end

  describe '#after_sign_in_path_for' do
    it 'always sends users to the admin_events_path' do
      user = double 'user'
      expect(controller.after_sign_in_path_for(user)).to eq admin_events_path
    end
  end

  describe 'setting default locale' do
    context 'a locale is passed in the params' do
      it 'gets the locale from the params' do
        get :index, params: { locale: 'fr' }
        expect(I18n.locale).to eq :'fr'
      end
    end

    context 'no locale is given in the params' do
      it 'uses the default locale' do
        I18n.default_locale = 'fr'
        get :index, params: {}
        expect(I18n.locale).to eq :'fr'
      end
    end
  end
end
