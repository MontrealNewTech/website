# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Partnership, type: :model do
  subject { build :partnership }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }

  it 'can store a translation in french for name and description' do
    partnership = create :partnership

    I18n.locale = :fr
    expect(partnership.name).to be_nil
    expect(partnership.description).to be_nil
  end
end
