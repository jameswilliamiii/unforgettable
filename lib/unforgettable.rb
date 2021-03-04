# frozen_string_literal: true

require 'rails'
require "active_record"

require_relative "unforgettable/version"

require 'unforgettable/engine' if defined?(Rails)
require 'unforgettable/railtie' if defined?(Rails::Railtie)
require 'unforgettable/models/release'
require 'unforgettable/tasks/release'

module Unforgettable
  class Error < StandardError; end
end
