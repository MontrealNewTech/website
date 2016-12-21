# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::ApplicationController, type: :controller do
  controller(Admin::ApplicationController) do
    def admin_route
      render body: nil
    end
  end

  before do
    @routes.draw { get :admin_route, controller: 'admin/application' }
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
        user = build_stubbed :user
        allow(controller).to receive(:current_user).and_return user
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
