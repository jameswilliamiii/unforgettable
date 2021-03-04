# frozen_string_literal: true

module Unforgettable
  class Engine < ::Rails::Engine
    paths["app/models"] << "lib/unforgettable/models/release"
  end
end