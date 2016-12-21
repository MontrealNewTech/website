# frozen_string_literal: true
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

  describe '#name' do
    let(:user) { build_stubbed :user, first_name: 'Kira', last_name: 'McLean' }

    it 'returns the first and last names of a user as one' do
      expect(user.name).to eq 'Kira McLean'
    end

    context 'user has no names' do
      let(:user) { build_stubbed :user, first_name: nil, last_name: nil }

      it 'returns an empty string' do
        expect(user.name).to eq ''
      end
    end

    context 'user has no first name' do
      let(:user) { build_stubbed :user, first_name: nil, last_name: 'Sagan' }

      it 'does not pad the last name' do
        expect(user.name).to eq 'Sagan'
      end
    end
  end
end
