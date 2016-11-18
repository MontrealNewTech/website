require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

 describe 'setting default role' do
    context 'no role is set' do
      it 'assigns default of :user' do
        user = create :user
        expect(user.role).to eq 'user'
      end
    end

    context 'admin role is set' do
      it 'assigns admin role' do
        user = create :user, role: :admin
        expect(user.role).to eq 'admin'
      end
    end
  end
end
