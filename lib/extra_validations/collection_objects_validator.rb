module ExtraValidations
  class CollectionObjectsValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, collection)
      return if !collection || collection.empty?

      collection
        .collect { |h| options[:with].new(h) }
        .each(&:valid?)
        .each_with_index do |obj, i|
          obj.errors.each do |attr, error|
            record.errors.add("#{attribute}/#{i}/#{attr}", error)
          end
        end
    end
  end
end
