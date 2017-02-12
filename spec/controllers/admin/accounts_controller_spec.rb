require 'rails_helper'

RSpec.describe Admin::AccountsController do
  it_behaves_like 'admin only controller'

  describe '#update' do
    let(:account) { build_stubbed :account }

    subject { patch :update, params: params }

    context 'making a regular user an admin' do
      let(:params) do
        {
          id: account.id,
          account: { admin: "true" }
        }
      end

      it 'changes the account from not admin to admin' do
        expect(account.admin?).to eq false
        subject
        expect(account.admin?).to eq true
      end

      it 'redirects to the admin index' do
        subject
        expect(response).to redirect_to admin_accounts_path
      end

      it 'sets a friendly flash message' do
        kubject
        expect(controller).to set_flash[:notice].to "Account was successfully updated."
      end
    end

    context 'making an admin user a regular user' do

    end
  end
end
