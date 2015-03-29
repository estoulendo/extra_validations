require 'spec_helper'

class DummyModelForExistenceValidation
  include ActiveModel::Model
  include ExtraValidations

  attr_accessor :model_id
end

describe ExtraValidations::ExistenceValidator do
  subject { DummyModelForExistenceValidation.new }

  before do
    DummyModelForExistenceValidation.clear_validators!
  end

  it 'allows nil values' do
    subject.class.validates :model_id, existence: ->(_) {}
    subject.model_id = nil
    expect(subject).to be_valid
  end

  context 'validator called without passing a Proc' do
    it 'raises an argument error' do
      expect do
        subject.class.validates :model_id, existence: true
      end.to raise_error(':with must be a Proc')
    end
  end

  context 'passed proc evaluates to false' do
    before do
      subject.class.validates :model_id, existence: ->(_) { false }
      subject.model_id = 123
    end

    it 'does not allow the value' do
      expect(subject).to_not be_valid
      expect(subject.errors[:model_id]).to eql(['not found'])
    end
  end

  context 'passed proc evaluates to true' do
    before do
      subject.class.validates :model_id, existence: ->(_) { true }
      subject.model_id = 123
    end

    it 'allows the value' do
      expect(subject).to be_valid
    end
  end
end
