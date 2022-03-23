# frozen_string_literal: true

require_relative "lib/rails-clusterid/version"

Gem::Specification.new do |spec|
  spec.name = "rails-clusterid"
  spec.version = ClusterId::Rails::VERSION
  spec.authors = ["Stephan Tarulli"]
  spec.email = ["srt@tinychameleon.com"]

  spec.summary = "Use ClusterId values in Rails."
  spec.description = "Use ClusterId values in Rails."
  spec.homepage = "https://github.com/tinychameleon/rails-clusterid"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = File.join(spec.homepage, "blob/main/CHANGELOG.md")
  spec.metadata["bug_tracker_uri"] = File.join(spec.homepage, "issues")
  spec.metadata["documentation_uri"] = "https://tinychameleon.github.io/rails-clusterid/"

  spec.files = Dir["README.md", "CHANGELOG.md", "LICENSE.txt", "lib/**/*.rb", "sig/**/*.rbs"]

  spec.require_paths = ["lib"]

  spec.add_dependency "crockford32", "~> 1.0"
  spec.add_dependency "clusterid", "~> 1.0"
  spec.add_dependency "rails", "~> 7.0"
end
