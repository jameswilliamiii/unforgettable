require "test_helper"
require_relative File.expand_path("../../../lib/generators/unforgetable/install_generator", __FILE__)

class Unforgetable::InstallGeneratorTest < ::Rails::Generators::TestCase
  include GeneratorTestHelpers

  tests Unforgetable::Generators::InstallGenerator
  destination File.expand_path("../tmp", File.dirname(__FILE__))

  create_generator_sample_app

  Minitest.after_run do
    remove_generator_sample_app
  end

  setup do
    run_generator
  end

  test "generates release.rake file" do
    file = "#{destination_root}/lib/tasks/release.rake"

    assert_path_exists(file)

    content = File.read(file)
    assert content.include?("RELEASE_VERSION = '0.0.0'.freeze")
    assert content.include?("task :release => :environment do")
    assert content.include?("task :unforgetable => :environment do")
  end

  test "generates migration" do
    dir = "#{destination_root}/db/migrate"
    assert_equal 3, Dir.entries(dir).length
  end
end
