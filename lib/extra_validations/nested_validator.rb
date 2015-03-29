module ExtraValidations
  class NestedValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, nested)
      return if !nested || nested.valid?

      nested.errors.each do |nested_attr, error|
        record.errors.add("#{attribute}/#{nested_attr}", error)
      end
    end
  end
end
