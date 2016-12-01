require 'rails_helper'

RSpec.describe Admin::ApplicationController do
  controller do
    def admin_route
      render body: nil
    end
  end

  before do
    @routes.draw { get :admin_route, controller: :anonymous }
  end

  describe 'authenticate_admin' do
    context 'user is an admin' do
      it 'lets the user in' do
        admin = build_stubbed :user, :admin
        allow(controller).to receive(:current_user).and_return admin
        get :admin_route
        expect(response).to have_http_status :ok
      end
    end

    context 'user is not an admin' do
      it 'does not let the user in' do
        # allow(controller).to receive(:current_user).and_return user
        user = build_stubbed :user
        # allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return user
        binding.pry
        get :admin_route
        expect(response).to redirect_to new_user_session_path
      end
    end

    context 'there is no current user' do
      it 'redirects to the login page' do
        allow(controller).to receive(:current_user).and_return nil
        get :admin_route
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
