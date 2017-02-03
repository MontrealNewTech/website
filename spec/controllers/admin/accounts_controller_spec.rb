require 'rails_helper'

RSpec.describe Admin::AccountsController do
  it_behaves_like 'admin only controller'

  describe '#update' do
    context 'making a regular user an admin' do

    end

    context 'making an admin user a regular user' do

    end
  end
end
