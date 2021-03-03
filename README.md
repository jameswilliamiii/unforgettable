# Unforgetable

Unforgetable generates release rails rake tasks and records when they get run.  Never forget to run post-release deploy rake tasks again!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unforgetable'
```

And then execute:

    $ bundle install

## Usage

Run the file generator with

    rails g unforgetable:install && rails db:migrate

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [Bitbucket](https://bitbucket.org/eightbitdevelopers/unforgetable).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).