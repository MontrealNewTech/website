# frozen_string_literal: true
RSpec.shared_context 'user is logged in' do
  before do
    user = double 'user', admin?: true
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
    allow(controller).to receive(:current_user).and_return user
  end
end
