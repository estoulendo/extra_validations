module ExtraValidations
  # Validates the length of a collection.
  #
  # Suppose that you have the following class:
  #
  #   class Book
  #     include ActiveModel::Model
  #     include ExtraValidations
  #
  #     attr_accessor :authors
  #
  #     validates :authors, collection_length: 1..5
  #   end
  #
  # This validator will make sure that the _authors_ array will have at least
  # 1 item and at most 5 items:
  #
  #   book = Book.new
  #   book.authors = []
  #   book.valid? # => false
  #
  #   book.authors = [Author.new]
  #   book.valid? # => true
  #
  class CollectionLengthValidator < ActiveModel::EachValidator
    def check_validity!
      fail ArgumentError, ':in must be a Range' unless options[:in].is_a?(Range)
    end

    # @param record An object that has ActiveModel::Validations included
    # @param attribute [Symbol]
    # @param collection [Array]
    def validate_each(record, attribute, collection)
      min = options[:in].begin
      max = options[:in].end

      if collection.blank? || collection.length < min
        record.errors.add(attribute, :too_few, count: min)
      end

      if collection.present? && collection.length > max
        record.errors.add(attribute, :too_many, count: max)
      end
    end
  end
end
