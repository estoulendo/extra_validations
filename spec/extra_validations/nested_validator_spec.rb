require 'spec_helper'

describe ExtraValidations::NestedValidator do
  let(:dummy_model) do
    Class.new do
      include ActiveModel::Model
      attr_accessor :name
      validates :name, presence: true

      def self.name
        'MyModelValidator'
      end
    end
  end

  subject do
    Class.new do
      include ActiveModel::Model
      include ExtraValidations

      attr_accessor :my_object
      validates :my_object, nested: true

      def self.name
        'MyModel'
      end
    end.new
  end

  it 'allows nil values' do
    subject.my_object = nil
    expect(subject).to be_valid
  end

  context 'valid nested object' do
    it 'allows the object' do
      subject.my_object = dummy_model.new(name: 'Foo bar')
      expect(subject).to be_valid
    end
  end

  context 'invalid nested object' do
    it 'ensures that the object is valid' do
      subject.my_object = dummy_model.new(name: '')
      expect(subject).to_not be_valid
      expect(subject.errors[:'my_object/name']).to eql(["can't be blank"])
    end
  end
end
