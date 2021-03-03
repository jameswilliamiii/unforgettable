# Update to use a unique release version
RELEASE_VERSION = '0.0.0'.freeze

desc 'Release specific logic that needs to run'
task :release => :environment do
  # Add any code that needs to be run on the next rake release
  #   `User.admin.update_all(state: 'active')`
  #
  # You can call other rake tasks to be run
  #   `Rake::Task['my_rake_namespace:my_rake_task'].invoke`

end

desc 'Runs all required release tasks and adds a versioned RakeRelease object in the database'
task :unforgetable => :environment do

  if CapRelease.find_by(version: RELEASE_VERSION)
    puts '*' * 100
    puts "Unforgetable: Version #{RELEASE_VERSION} has already been run! Did you forget to update the RELEASE_VERSION constant?"
    puts '*' * 100
  else
    puts '*' * 100
    puts "Unforgetable: Running version #{RELEASE_VERSION}"


    ActiveRecord::Base.transaction do
      Rake::Task['release'].invoke
      CapRelease.create!(version: RELEASE_VERSION)
    end

    puts "Unforgetable: Finished version #{RELEASE_VERSION}"
    puts '*' * 100
  end
end
