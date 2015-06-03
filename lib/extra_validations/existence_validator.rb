module ExtraValidations
  # Makes sure that an object/record exists.
  #
  # Suppose that you have the following class:
  #
  #   class Book
  #     include ActiveModel::Model
  #     include ExtraValidations
  #
  #     attr_accessor :author_id
  #
  #     validates :author_id, existence: -> (id) { Author.exists?(id) }
  #   end
  #
  # This validator will execute the given block and, if it returns false, the
  # object will not be valid:
  #
  #   book = Book.new
  #   book.author_id = 100
  #   book.valid? # => false
  #
  #   book.author_id = Author.first.id
  #   book.valid? # => true
  #
  class ExistenceValidator < ActiveModel::EachValidator
    def check_validity!
      unless options[:with].is_a?(Proc)
        fail ArgumentError, ':with must be a Proc'
      end
    end

    # @param record An object that has ActiveModel::Validations included
    # @param attribute [Symbol]
    # @param id [Integer]
    def validate_each(record, attribute, id)
      return if id.blank?

      success = options[:with].call(id)
      record.errors.add(attribute, :not_found) unless success
    end
  end
end
