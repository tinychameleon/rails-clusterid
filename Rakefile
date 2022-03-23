# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"
require "yard"

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb", "-", "CHANGELOG.md"]
  t.options = ["--private", "-o", "./docs"]
end

task :test do
  sh "docker run --rm -ti -v $PWD:/workspace rails-clusterid:ruby-3.1.1 bin/test -e test_sqlite"
end

task default: %i[test standard]

desc "Type check via tests"
task :rbs do
  sh "bundle exec rbs -I sig test --target 'ClusterId::Rails::*' bundle exec rake test"
end
