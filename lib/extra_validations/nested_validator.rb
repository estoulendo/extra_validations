module ExtraValidations
  # Makes sure that the nested object is valid.
  #
  # Suppose that you have the following class:
  #
  #   class Book
  #     include ActiveModel::Model
  #     include ExtraValidations
  #
  #     attr_accessor :author
  #
  #     validates :author, nested: true
  #   end
  #
  # This validator will call +#valid?+ on the nested object:
  #
  #   book = Book.new
  #   book.author = invalid_author
  #   book.valid? # => false
  #
  #   book.author = valid_author
  #   book.valid? # => true
  #
  # Each validation error found will be appended on to the errors object:
  #
  #   book.errors.messages # => {:"author/name"=>["can't be blank"]}
  #
  class NestedValidator < ActiveModel::EachValidator
    # @param record An object that has ActiveModel::Validations included
    # @param attribute [Symbol]
    # @param nested An object that has ActiveModel::Validations included
    def validate_each(record, attribute, nested)
      return if !nested || nested.valid?

      nested.errors.each do |nested_attr, error|
        record.errors.add("#{attribute}/#{nested_attr}", error)
      end
    end
  end
end
