# ExtraValidations

[![Build Status][travis_badge]][travis_link]
[![Code Climate][cclimate_badge]][cclimate_link]

This gem provides some extra validations for ActiveModel objects.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'extra_validations'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install extra_validations

## Usage

The following validators are available:

Collection length:

```ruby
validates :attr, collection_length: { in: 1..5 }
```

Collection members validator (ensures that each member of the collection is
valid):

```ruby
validates :attr, collection: true
```

Existence validator:

```ruby
validates :model_id, existence: ->(value) { Model.exists?(value) }
```

Nested validator (ensures that the object is valid):

```ruby
validates :model, nested: true
```

Uniqueness validator:

```ruby
validates :email, uniqueness: ->(email) { Model.exists?(email: email) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release` to create a git tag for the version, push git
commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/estoulendo/extra_validations/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[travis_badge]: https://travis-ci.org/estoulendo/extra_validations.svg?branch=master
[travis_link]: https://travis-ci.org/estoulendo/extra_validations
[cclimate_badge]: https://codeclimate.com/github/estoulendo/extra_validations/badges/gpa.svg
[cclimate_link]: https://codeclimate.com/github/estoulendo/extra_validations
