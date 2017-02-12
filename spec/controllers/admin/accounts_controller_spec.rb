# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Admin::AccountsController do
  it_behaves_like 'admin only controller'

  describe '#update' do
    subject { patch :update, params: params }

    include_context 'user is logged in' do
      context 'update works' do
        let(:params) do
          {
            id: account.id,
            account: { admin: 'true' }
          }
        end

        describe 'redirecting and setting the flash' do
          let(:account) { build_stubbed :account }

          before do
            allow(Account).to receive(:find).with(account.id.to_s).and_return account
            allow(account).to receive(:update).and_return true
          end

          it 'redirects to the admin index' do
            subject
            expect(response).to redirect_to admin_accounts_path
          end

          it 'sets a friendly flash message' do
            subject
            expect(controller).to set_flash[:notice].to t('flash.accounts.success')
          end
        end

        context 'actually updating the user to make a regular user an admin' do
          let(:account) { create :account }

          it 'changes the account from not admin to admin' do
            expect(account.admin?).to eq false
            subject
            account.reload
            expect(account.admin?).to eq true
          end
        end
      end

      context 'udpate fails' do
        let(:params) do
          {
            id: account.id,
            account: { admin: 'No' }
          }
        end

        describe 'redirecting and setting the flash' do
          let(:account) { build_stubbed :account }

          before do
            allow(Account).to receive(:find).with(account.id.to_s).and_return account
            allow(account).to receive(:update).and_return false
          end

          it 're-renders the template' do
            subject
            expect(response.status).not_to eq :redirect
            expect(response.status).to eq 200
          end

          it 'sets a friendly flash message' do
            subject
            expect(controller).to set_flash[:alert].to t('flash.accounts.failure')
          end
        end

        context 'actually updating the user fails' do
          let(:account) { create :account }

          it 'does not change the account from not admin to admin' do
            expect(account.admin?).to eq false
            subject
            account.reload
            expect(account.admin?).to eq false
          end
        end
      end
    end
  end
end
