# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_one :account}
  it { is_expected.to delegate_method(:admin?).to :account }

  its(:account) { is_expected.to be_present }

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
