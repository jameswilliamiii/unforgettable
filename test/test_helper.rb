# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "unforgettable"
require "minitest/autorun"
require "pry"
require "timecop"

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

BASE_DIR = File.expand_path("..", File.dirname(__FILE__))
TMP_APP_LOCATION = BASE_DIR + "/tmp"

class Minitest::Test
  include GeneratorTestHelpers

  create_generator_sample_app

  Minitest.after_run do
    remove_generator_sample_app
  end
end
