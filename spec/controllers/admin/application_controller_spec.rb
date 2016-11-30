require 'rails_helper'

RSpec.describe Admin::ApplicationController do
  controller do
    def admin_route
      # authenticate_admin
    end
  end

  before do
    @routes.draw { get :admin_route, controller: :anonymous }
  end

  describe 'authenticate_admin' do
    context 'user is an admin' do
      let(:admin) { build_stubbed :user, :admin }

      before do
        allow(controller).to receive(:current_user).and_return admin
      end

      it 'lets the user in' do
        get :admin_route
        expect(response).to have_http_status 200
      end
    end

    context "user is not an admin" do
      it "does not let the user in" do

      end
    end
  end
end

  # describe 'user_not_authorized' do
  #
  #   it 'sets the flash when user is unauthorized' do
  #     request.env['HTTP_REFERER'] = nil
  #     get :access_denied
  #     expect(controller).to set_flash[:alert].to t('unauthorized')
  #     expect(controller).to redirect_to root_path
  #   end
  #
  #   it 'redirects back when there is a request referrer' do
  #     request.env['HTTP_REFERER'] = 'back path'
  #     get :access_denied
  #     expect(controller).to redirect_to 'back path'
  #   end
  # end
  #
  # describe 'after_sign_in_path' do
  #   it 'redirects to events after login' do
  #     user = build_stubbed :user
  #     expect(controller.after_sign_in_path_for(user)).to eq events_path
  #   end
  # end
  #
