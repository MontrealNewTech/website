# frozen_string_literal: true
require 'rails_helper'

RSpec.describe MemberProfile, type: :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :team }

  it { is_expected.to validate_presence_of :team }
  it { is_expected.to validate_presence_of :name }

  it { is_expected.to delegate_method(:email).to(:user).with_prefix }

  it 'can store a translation in french for name, position, and bio' do
    member_profile = create :member_profile

    I18n.locale = :fr
    expect(member_profile.position).to be_nil
    expect(member_profile.bio).to be_nil
  end
end
