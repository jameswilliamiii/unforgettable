require "test_helper"
require_relative File.expand_path("../../../lib/generators/unforgettable/task_generator", __FILE__)

class Unforgettable::TaskGeneratorTest < ::Rails::Generators::TestCase

  tests Unforgettable::Generators::TaskGenerator
  destination TMP_APP_LOCATION

  setup do
    Timecop.freeze(Time.now)
    run_generator
  end

  test "generates release rake file" do
    release_id = Time.now.strftime('%Y%m%d%H%M%S')
    file = "#{destination_root}/lib/tasks/unforgettable/release_#{release_id}.rake"

    assert_path_exists(file)

    Timecop.return

    content = File.read(file)
    assert content.include?("namespace :unforgettable do")
    assert content.include?("desc \"Unforgettable release task #{release_id}\"")
    assert content.include?("task :release_#{release_id} => :environment do")
  end
end
