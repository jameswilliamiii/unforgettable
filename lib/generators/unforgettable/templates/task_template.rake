namespace :unforgettable do
  desc "Unforgettable release task <%= release_id %>"
  task <%= task_name %> => :environment do
    # Add any code that needs to be run by unforgettable
    #   `User.admin.update_all(state: 'active')`
    #
    # You can call other rake tasks to be run
    #   `Rake::Task['my_rake_namespace:my_rake_task'].invoke`
  end
end
