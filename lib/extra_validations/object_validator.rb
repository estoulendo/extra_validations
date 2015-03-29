module ExtraValidations
  class ObjectValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, hash)
      obj = options[:with].new(hash)
      return if obj.valid?

      obj.errors.each do |attr, error|
        record.errors.add("#{attribute}/#{attr}", error)
      end
    end
  end
end
