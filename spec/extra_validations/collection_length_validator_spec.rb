require 'spec_helper'

describe ExtraValidations::CollectionLengthValidator do
  subject do
    Class.new do
      include ActiveModel::Model
      include ExtraValidations

      attr_accessor :my_collection
      validates :my_collection, collection_length: 1..5

      def self.name
        'MyModel'
      end
    end.new
  end

  context 'validator called without passing a range' do
    it 'raises an argument error' do
      expect do
        subject.class.validates :my_collection, collection_length: []
      end.to raise_error(':in must be a Range')
    end
  end

  it 'ensures that the collection has the minimum length' do
    subject.my_collection = []
    expect(subject).to_not be_valid
    expect(subject.errors[:my_collection]).to include('must have at least one')
  end

  it 'ensures that the collection has the maximum length' do
    subject.my_collection = (1..6).to_a
    expect(subject).to_not be_valid
    expect(subject.errors[:my_collection]).to include('must have at most 5')
  end

  it 'does not allow nil values' do
    subject.my_collection = nil
    expect(subject).to_not be_valid
    expect(subject.errors[:my_collection]).to include('must have at least one')
  end

  it 'allows collections with lengths between the maximum and minimum' do
    subject.my_collection = (1..5).to_a
    expect(subject).to be_valid
  end
end
