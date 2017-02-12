# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to belong_to :user }
  its(:admin?) { is_expected.to eq false }

  it { is_expected.to delegate_method(:email).to(:user).with_prefix }
end
