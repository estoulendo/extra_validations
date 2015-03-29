require 'spec_helper'

class NestedDummyModel
  include ActiveModel::Model
  attr_accessor :name

  validates :name, presence: true
end

class DummyModelForNestedValidation
  include ActiveModel::Model
  include ExtraValidations

  attr_accessor :my_object
  validates :my_object, nested: true
end

describe ExtraValidations::NestedValidator do
  subject { DummyModelForNestedValidation.new }

  it 'allows nil values' do
    subject.my_object = nil
    expect(subject).to be_valid
  end

  context 'valid nested object' do
    it 'allows the object' do
      subject.my_object = NestedDummyModel.new(name: 'Foo bar')
      expect(subject).to be_valid
    end
  end

  context 'invalid nested object' do
    it 'ensures that the object is valid' do
      subject.my_object = NestedDummyModel.new(name: '')
      expect(subject).to_not be_valid
      expect(subject.errors[:'my_object/name']).to eql(["can't be blank"])
    end
  end
end
