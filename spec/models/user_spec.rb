# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }

  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to have_one :account }
  it { is_expected.to delegate_method(:admin?).to :account }

  its(:account) { is_expected.to be_present }
end
