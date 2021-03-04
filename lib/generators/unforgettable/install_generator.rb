require 'rails/generators'
require 'rails/generators/active_record'

module Unforgettable
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc "Generate a migration for unforgettable_releases"
      source_root File.join(File.dirname(__FILE__), "templates")

      def generate_migration
        migration_template "migration_template.rb", "db/migrate/create_unforgettable_releases.rb", migration_version: migration_version
      end

      private

      def migration_version
        if defined?(Rails::VERSION) && Rails::VERSION::MAJOR >= 5
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end
    end
  end
end
