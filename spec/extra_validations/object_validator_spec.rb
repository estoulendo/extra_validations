require 'spec_helper'

describe ExtraValidations::ObjectValidator do
  class DummyObjValidator
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

      attr_accessor :my_object
      validates :my_object, object: DummyObjValidator

      def self.name
        'MyModel'
      end
    end.new
  end

  it 'ensures that the object is valid' do
    subject.my_object = { name: '' }
    expect(subject).to_not be_valid
    expect(subject.errors[:'my_object/name']).to eql(["can't be blank"])
  end

  it 'allows valid objects' do
    subject.my_object = { name: 'Foo' }
    expect(subject).to be_valid
  end
end
