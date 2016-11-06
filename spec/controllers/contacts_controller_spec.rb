require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe 'POST #create' do
    let(:http_params) { attributes_for :contact }

    subject { post :create, params: { contact: http_params }, format: :js }

    it_behaves_like 'successful request'
    it_behaves_like 'action that is allowed for guests'

    context 'with valid params' do
      it 'creates a new contact' do
        expect{ subject }.to change(Contact, :count).by 1
      end
    end

    context 'with invalid params' do
      let(:http_params) { { email: 'invalid@email' } }

      it 'does not create a new contact' do
        expect{ subject }.not_to change(Contact, :count)
      end
    end
  end
end
