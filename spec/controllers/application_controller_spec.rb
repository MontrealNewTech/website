require 'rails_helper'

RSpec.describe ApplicationController do
  describe '#after_sign_in_path_for' do
    it 'always sends users to the admin_events_path' do
      user = double 'user'
      expect(controller.after_sign_in_path_for(user)).to eq admin_events_path
    end
  end
end
