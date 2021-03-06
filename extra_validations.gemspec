# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'extra_validations/version'

Gem::Specification.new do |spec|
  spec.name          = 'extra_validations'
  spec.version       = ExtraValidations::VERSION
  spec.authors       = ['Lenon Marcel']
  spec.email         = ['lenon.marcel@gmail.com']

  spec.summary       = 'Provides some extra validations for ActiveModel.'
  spec.description   = 'Provides some extra validations for ActiveModel.'
  spec.homepage      = 'https://github.com/estoulendo/extra_validations'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activemodel', '~> 4.2'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
end
