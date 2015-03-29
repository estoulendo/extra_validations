require 'active_model'

require 'extra_validations/version'
require 'extra_validations/collection_length_validator'
require 'extra_validations/collection_validator'
require 'extra_validations/object_validator'

I18n.load_path.unshift(*Dir[File.expand_path(
  File.join(%w(extra_validations locale *.yml)), File.dirname(__FILE__))])

module ExtraValidations
end
