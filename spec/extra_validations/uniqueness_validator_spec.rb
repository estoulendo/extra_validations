require 'spec_helper'

class DummyModelForUniquenessValidator
  include ActiveModel::Model
  include ExtraValidations

  attr_accessor :email
end

describe ExtraValidations::UniquenessValidator do
  subject { DummyModelForUniquenessValidator.new }

  before do
    DummyModelForUniquenessValidator.clear_validators!
  end

  it 'allows nil values' do
    subject.class.validates :email, uniqueness: ->(_) {}
    subject.email = nil
    expect(subject).to be_valid
  end

  context 'validator called without passing a Proc' do
    it 'raises an argument error' do
      expect do
        subject.class.validates :email, uniqueness: true
      end.to raise_error(':with must be a Proc')
    end
  end

  context 'passed proc evaluates to true' do
    before do
      subject.class.validates :email, uniqueness: ->(_) { true }
      subject.email = 'foo@example.com'
    end

    it 'does not allow the value' do
      expect(subject).to_not be_valid
      expect(subject.errors[:email]).to eql(['has already been taken'])
    end
  end

  context 'passed proc evaluates to false' do
    before do
      subject.class.validates :email, uniqueness: ->(_) { false }
      subject.email = 'foo@example.com'
    end

    it 'allows the value' do
      expect(subject).to be_valid
    end
  end
end
