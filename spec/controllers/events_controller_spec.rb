require 'rails_helper'
RSpec.describe EventsController, type: :controller do
  describe "GET #index" do
    it_behaves_like 'action that is allowed for guests'

    include_context 'user is logged in' do
      it_behaves_like 'successful request'
    end
  end
end
