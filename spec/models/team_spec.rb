# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to have_many :member_profiles }

  it 'can store a translation in french for name and description' do
    team = create :team

    I18n.locale = :fr
    expect(team.name).to be_nil
    expect(team.description).to be_nil

    I18n.locale = I18n.default_locale
  end
end
