# Configure Rails Environment
ALLOWED_ENVS = ["test_sqlite", "test_postgresql", "test_mysql"].freeze
test_env = ENV["RAILS_ENV"]
raise StandardError, "Bad test env: #{test_env}" unless ALLOWED_ENVS.include?(test_env)

# Testing tools
require "debug"

# Rails test initialization
require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __dir__)]
require "rails/test_help"

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("fixtures", __dir__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
