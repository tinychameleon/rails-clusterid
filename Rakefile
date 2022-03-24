# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"
require "yard"

RUBY_VERSION = "3.1.1"
IMAGE_TAG = "rails-clusterid:ruby-#{RUBY_VERSION}"
DOCKER_RUN = "docker run --rm -ti -v $PWD:/workspace #{IMAGE_TAG}"

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb", "-", "CHANGELOG.md"]
  t.options = ["--private", "-o", "./docs"]
end

desc "Run tests against sqlite"
task test: %i[image] do
  sh "#{DOCKER_RUN} bin/test -e test_sqlite"
end

desc "Type check the current implementation"
task typecheck: %i[image] do
  sh "#{DOCKER_RUN} bundle exec rake rbs"
end

task default: %i[test standard]

task :image do
  sh "docker build --rm -ti -t #{IMAGE_TAG} --build-arg RUBY_VERSION=#{RUBY_VERSION} ."
end

task :rbs do
  sh "bundle exec rbs -I sig test --target 'ClusterId::*' bin/test -e test_sqlite"
end
