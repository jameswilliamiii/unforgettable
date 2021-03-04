namespace :unforgettable do
  desc "Unforgettable primary release task"
  task :release => :environment do
    Unforgettable::Tasks::Release.call
  end
end
