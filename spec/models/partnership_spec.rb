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

  describe 'relationships' do
    Partnership::PARTNERSHIP_TYPES.each do |relationship_type|
      it "allows #{relationship_type}" do
        partnership = build(:partnership, relationship: relationship_type)
        expect(partnership).to be_valid
      end
    end

    it 'is invalid with a disallowed relationship type' do
      partnership = build(:partnership, relationship: 'nope not allowed')
      expect(partnership).not_to be_valid
      expect(partnership.errors.keys).to eq [:relationship]
    end

    it 'is invalid with an empty relationship type' do
      partnership = build(:partnership, relationship: nil)
      expect(partnership).not_to be_valid
      expect(partnership.errors.keys).to eq [:relationship]
    end

    it 'is invalid with a blank relationship type' do
      partnership = build(:partnership, relationship: '')
      expect(partnership).not_to be_valid
      expect(partnership.errors.keys).to eq [:relationship]
    end
  end
end
