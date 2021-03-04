# Unforgettable

How many times have you deployed a new release of a rails app and forgot to run a post-release rake tasks?  Unforgettable tracks which tasks it has run previously, and which tasks still need to be invoked. Never forget to run post-release deploy rake tasks again!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'unforgettable'
```

And then execute:

    bundle install

Run the generator to create a migration for the table that will be used to track the tasks that Unforgettable invokes.

    rails g unforgettable:install
    rails db:migrate
## Usage

Generate new release tasks by running:

    rails g unforgettable:task

This will create a new *.rake file in the folder `lib/tasks/unforgettable`.  You can then insert whatever code you need to run during your next Unforgettable release.

You can trigger all previously uninvoked Unforgettable release tasks by running

    $ rails unforgettable:release

### Integration with Capistrano

You can integrate Unforgettable with Capistrano deploys by adding the below to your `deploy.rb` file.

```ruby
namespace :deploy do
  desc 'Invoke any new Unforgettable release tasks'
  task :release do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'unforgettable:release'
        end
      end
    end
  end
end

after 'deploy:published',  'deploy:release'
```

### Rerunning Completed Tasks

Unforgettable records all tasks that have been run as a row on the `unforgettable_releases` table.

    irb(main):002:0> Unforgettable::Release.all
    => #<ActiveRecord::Relation [#<Unforgettable::Release id: 1, version: "release_20210303203356", created_at: "2021-03-04 02:37:49", updated_at: "2021-03-04 02:37:49">]>

You can delete a previous record to force Unforgettable to run the task again.
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [Bitbucket](https://bitbucket.org/eightbitdevelopers/unforgettable).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
