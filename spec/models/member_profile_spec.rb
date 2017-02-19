# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MemberProfile, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :team }

  it { is_expected.to validate_presence_of :team }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to delegate_method(:email).to(:user).with_prefix }
end
