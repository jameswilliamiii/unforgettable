# frozen_string_literal: true

require_relative "lib/unforgettable/version"

Gem::Specification.new do |spec|
  spec.name          = "unforgettable"
  spec.version       = Unforgettable::VERSION
  spec.authors       = ["James Stubblefield"]

  spec.summary       = "A utility to run release tasks at the end of your deployment."
  # spec.description   = "TODO: Write a longer description or delete this line."
  spec.homepage      = "https://bitbucket.org/eightbitdevelopers/unforgettable"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://bitbucket.org/eightbitdevelopers/unforgettable"
  spec.metadata["changelog_uri"] = "https://bitbucket.org/eightbitdevelopers/unforgettable/src/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"

  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "timecop"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
