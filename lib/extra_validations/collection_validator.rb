module ExtraValidations
  # Makes sure that each member of the collection is a valid object.
  #
  # Suppose that you have the following class:
  #
  #   class Book
  #     include ActiveModel::Model
  #     include ExtraValidations
  #
  #     attr_accessor :authors
  #
  #     validates :authors, collection: true
  #   end
  #
  # This validator will call +#valid?+ for each member of the collection:
  #
  #   book = Book.new
  #   book.authors = [invalid_author1, valid_author1]
  #   book.valid? # => false
  #
  #   book.authors = [valid_author1, valid_author2]
  #   book.valid? # => true
  #
  # Each validation error found on members will be appended on to the errors
  # object:
  #
  #   book.errors.messages # => {:"authors/1/name"=>["can't be blank"]}
  #
  class CollectionValidator < ActiveModel::EachValidator
    # @param record An object that has ActiveModel::Validations included
    # @param attribute [Symbol]
    # @param collection [Array] An array of objects that have
    #   ActiveModel::Validations included
    def validate_each(record, attribute, collection)
      return if collection.blank?

      collection
        .each(&:valid?)
        .each_with_index do |obj, i|
          obj.errors.each do |attr, error|
            record.errors.add("#{attribute}/#{i}/#{attr}", error)
          end
        end
    end
  end
end
