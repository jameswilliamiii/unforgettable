require 'rails/generators'

module Unforgettable
  module Generators
    class TaskGenerator < Rails::Generators::Base

      desc "Create an unforgettable release rake task"
      source_root File.join(File.dirname(__FILE__), "templates")

      def create_rakefile
        template('task_template.rake', "lib/tasks/unforgettable/release_#{release_id}.rake")
      end

      private

      def release_id
        @release_id ||= Time.now.strftime('%Y%m%d%H%M%S')
      end

      def task_name
        ":release_#{release_id}".to_sym
      end
    end
  end
end
