require 'rails_helper'

RSpec.describe KeywordStruct do
  TestClass = described_class.new(:first, :second)

  it 'can be initialized with keyword arguments' do
    test = TestClass.new first: 'a value', second: 'another value'

    expect(test.first).to eq 'a value'
    expect(test.second).to eq 'another value'
  end

  it 'does not care about the order of the arguments it gets' do
    test = TestClass.new second: 'a value', first: 'another value'

    expect(test.second).to eq 'a value'
    expect(test.first).to eq 'another value'
  end

  context 'when given an incomplete list of keyword args' do
    subject { TestClass.new first: 'only first arg is here' }

    it 'does not require any of the keyword arguments' do
      expect{ subject }.not_to raise_error
    end

    it 'defaults any missing keyword arguments to nil' do
      expect(subject.first).to eq 'only first arg is here'
      expect(subject.second).to eq nil
    end
  end

  context 'when given an argument not in the list' do
    subject { TestClass.new first: 'a value', not_in_here: 'bad_key' }

    it 'gives you a nice and meaningful error message' do
      expect{ subject }.to raise_error NameError
    end
  end
end
