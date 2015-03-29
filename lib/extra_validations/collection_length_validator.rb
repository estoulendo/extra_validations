module ExtraValidations
  class CollectionLengthValidator < ActiveModel::EachValidator
    def check_validity!
      unless options[:in].is_a?(Range)
        fail ArgumentError, ':in must be a Range'
      end
    end

    def validate_each(record, attribute, collection)
      min = options[:in].begin
      max = options[:in].end

      collection_any = collection && collection.any?

      if !collection_any || collection.length < min
        record.errors.add(attribute, :too_few, count: min)
      end

      if collection_any && collection.length > max
        record.errors.add(attribute, :too_many, count: max)
      end
    end
  end
end
