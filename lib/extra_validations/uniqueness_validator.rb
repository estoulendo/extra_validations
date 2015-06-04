module ExtraValidations
  # Makes sure that an object/record is unique.
  #
  # Suppose that you have the following class:
  #
  #   class User
  #     include ActiveModel::Model
  #     include ExtraValidations
  #
  #     attr_accessor :email
  #
  #     validates :email, uniqueness: ->(email) { User.exists?(email: email) }
  #   end
  #
  # This validator will execute the given block and, if it returns true, the
  # object will not be valid:
  #
  #   user = User.new
  #   user.email = 'foo@example.com'
  #   user.valid? # => false
  #
  #   user.email = 'bar@example.com'
  #   user.valid? # => true
  #
  class UniquenessValidator < ActiveModel::EachValidator
    def check_validity!
      unless options[:with].is_a?(Proc)
        fail ArgumentError, ':with must be a Proc'
      end
    end

    # @param record An object that has ActiveModel::Validations included
    # @param attribute [Symbol]
    # @param value
    def validate_each(record, attribute, value)
      return if value.blank?

      exists = options[:with].call(value)
      record.errors.add(attribute, :taken) if exists
    end
  end
end
