require 'rails_helper'

RSpec.describe Organization, type: :model do
  subject { build :organization }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
