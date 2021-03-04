module Unforgettable
  module Tasks
    class Release
      class << self
        def call
          new_tasks.each { |task| run!(task) }
        end

        private

        def new_tasks
          previous_tasks = Unforgettable::Release.pluck(:version)
          all_tasks.reject { |task| previous_tasks.include?(task) }
        end

        def all_tasks
          filenames = Dir.entries(unforgettable_folder).reject {|f| File.directory?(f) || f[0].include?('.')}
          filenames.map { |filename| filename.split('.')[0] }
        end

        def unforgettable_folder
          File.join(Rails.root, 'lib', 'tasks', 'unforgettable')
        end

        def run!(task_name)
          print_border
          puts "Running #{task_name}"
          Rake::Task["unforgettable:#{task_name}"].invoke
          create_record(task_name)
          print_border
        end

        def print_border
          puts "*" * 80
        end

        def create_record(task_name)
          Unforgettable::Release.create(version: task_name)
        end
      end
    end
  end
end