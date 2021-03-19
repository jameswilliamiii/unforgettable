require "test_helper"
require_relative File.expand_path("../../../lib/generators/unforgettable/install_generator", __FILE__)

class Unforgettable::InstallGeneratorTest < ::Rails::Generators::TestCase

  tests Unforgettable::Generators::InstallGenerator
  destination TMP_APP_LOCATION

  setup do
    run_generator
  end

  test "generates migration" do
    dir = "#{destination_root}/db/migrate"
    assert_equal 3, Dir.entries(dir).length
  end

  test "generates the unforgettable folder" do
    file = "#{destination_root}/lib/tasks/unforgettable/.keep"

    assert_path_exists(file)
  end
end
