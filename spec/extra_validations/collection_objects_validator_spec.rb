require 'spec_helper'

describe ExtraValidations::CollectionObjectsValidator do
  class DummyValidator
    include ActiveModel::Model
    attr_accessor :name
    validates :name, presence: true

    def self.name
      'MyModelValidator'
    end
  end

  subject do
    Class.new do
      include ActiveModel::Model
      include ExtraValidations

      attr_accessor :my_collection
      validates :my_collection, collection_objects: DummyValidator

      def self.name
        'MyModel'
      end
    end.new
  end

  it 'ensures that each object in the collection is valid' do
    subject.my_collection = [{ name: 'Foo' }, { name: '' }]
    expect(subject).to_not be_valid
    expect(subject.errors[:'my_collection/1/name']).to eql(["can't be blank"])
  end

  it 'allows empty collections' do
    subject.my_collection = []
    expect(subject).to be_valid
  end

  it 'allows valid objects' do
    subject.my_collection = [{ name: 'Foo' }]
    expect(subject).to be_valid
  end

  it 'allows nil values' do
    subject.my_collection = nil
    expect(subject).to be_valid
  end
end
