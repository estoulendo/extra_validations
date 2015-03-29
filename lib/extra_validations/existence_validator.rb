module ExtraValidations
  class ExistenceValidator < ActiveModel::EachValidator
    def check_validity!
      unless options[:with].is_a?(Proc)
        fail ArgumentError, ':with must be a Proc'
      end
    end

    def validate_each(record, attribute, id)
      return if id.blank?

      success = options[:with].call(id)
      record.errors.add(attribute, :not_found) unless success
    end
  end
end
