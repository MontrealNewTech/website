# frozen_string_literal: true
RSpec.shared_context 'user is logged in' do
  before do
    user = double 'user'
    allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  end
end

RSpec.shared_context 'user is authorized' do
  before { allow(controller).to receive(:authorize).and_return true }
end
