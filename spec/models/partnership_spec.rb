# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Partnership, type: :model do
  subject { build :partnership }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
end
