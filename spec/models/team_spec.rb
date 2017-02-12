require 'rails_helper'

RSpec.describe Team, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to have_many :team_member_profiles }
end
