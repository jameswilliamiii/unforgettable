# Unforgettable

How many times have you deployed a new release of a rails app and forgot to run a post-release rake task?  Unforgettable tracks which tasks it has run previously, and which tasks still need to be invoked. Never forget to run post-release deploy rake tasks again!

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

### Integration with Kamal

You can integrate Unforgettable with Kamal deploys by calling it from a post-deploy hook.
Create a file `post-deploy` under the `.kmal` folder in the root of your project.  The integration should look somethingt like:

```ruby

$stdout.sync = true

$stderr.puts "Running bin/rails unforgettable:release on remote Docker containers..."

def get_container_name(host)
  base_name = "grogo-web"
  destination = ENV["KAMAL_DESTINATION"]
  version = ENV["KAMAL_VERSION"]

  potential_names = [
    [ base_name, destination, version ].reject { |v| v.to_s.strip.empty? }.join("-"),
    [ base_name, version ].reject { |v| v.to_s.strip.empty? }.join("-")
  ]

  # Check potential names to see which matches a container id on the server.
  potential_names.each do |name|
    command = "ssh deploy@#{host} \"docker ps --format '{{.Names}}' | grep #{name}\""
    result = `#{command}`.strip
    return result unless result.empty?
  end

  nil
end

def execute_task(host, container_name)
  task = "bin/rails unforgettable:release"
  remote_host = "deploy@#{host}"

  command = "ssh #{remote_host} 'docker exec #{container_name} #{task}'"
  unless system(command)
    $stderr.puts "Failed to execute rake task on remote Docker container: #{task} for host #{host}"
  end
end

ENV["KAMAL_HOSTS"].to_s.split(",").each do |host|
  container_name = get_container_name(host)
  execute_task(host, container_name)
end
```

Note: Kamal will not show the $stdout by default.  Run Kamal in verbose mode with `kamal deploy -v` in order to see any output.

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
