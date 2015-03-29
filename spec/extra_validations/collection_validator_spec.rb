require 'spec_helper'

class DummyModelForCollection
  include ActiveModel::Model

  attr_accessor :name
  validates :name, presence: true
end

class DummyModelForCollectionValidation
  include ActiveModel::Model
  include ExtraValidations

  attr_accessor :my_collection
  validates :my_collection, collection: true
end

describe ExtraValidations::CollectionValidator do
  subject { DummyModelForCollectionValidation.new }

  it 'allows empty collections' do
    subject.my_collection = []
    expect(subject).to be_valid
  end

  it 'allows nil values' do
    subject.my_collection = nil
    expect(subject).to be_valid
  end

  context 'collection with invalid objects' do
    before do
      subject.my_collection = []
      subject.my_collection << DummyModelForCollection.new(name: 'Foo')
      subject.my_collection << DummyModelForCollection.new(name: '')
    end

    it 'ensures that each object in the collection is valid' do
      expect(subject).to_not be_valid
      expect(subject.errors[:'my_collection/1/name']).to eql(["can't be blank"])
    end
  end

  context 'collections with only valid objects' do
    before do
      subject.my_collection = []
      subject.my_collection << DummyModelForCollection.new(name: 'Foo')
      subject.my_collection << DummyModelForCollection.new(name: 'Bar')
    end

    it 'allows all objects' do
      expect(subject).to be_valid
    end
  end
end
