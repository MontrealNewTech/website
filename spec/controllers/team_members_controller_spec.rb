require 'rails_helper'

RSpec.describe TeamMembersController, type: :controller do
  describe "GET #index" do
    subject { get :index, params: { locale: I18n.locale.to_param } }

    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end
  end
end
