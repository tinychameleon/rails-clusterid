# frozen_string_literal: true

require "test_helper"

class RailsClusterIdRailtieTest < ActiveSupport::TestCase
  test "registers the clusterid configuration object" do
    assert_includes ::Rails::Application::Configuration.instance_methods, :clusterid
  end

  test "registers a native type for the database adapter" do
    refute_nil ::ActiveRecord::Base.connection.native_database_types[:clusterid]
  end

  test "native type for PostgreSQL is bytea" do
    type = ::ClusterId::Rails::Railtie.instance.send(:native_type, :postgresql)
    assert_equal "bytea", type[:name]
  end

  test "native type for MySQL is binary(16)" do
    type = ::ClusterId::Rails::Railtie.instance.send(:native_type, :mysql2)
    assert_equal "binary", type[:name]
    assert_equal 16, type[:limit]
  end

  test "native type for SQLite is blob" do
    type = ::ClusterId::Rails::Railtie.instance.send(:native_type, :sqlite3)
    assert_equal "blob", type[:name]
  end

  test "adds the clusterid method to the TableDefinition class" do
    assert_includes ::ActiveRecord::ConnectionAdapters::TableDefinition.instance_methods, :clusterid
  end

  test "registers the clusterid ActiveRecord type" do
    assert_kind_of ::ClusterId::Rails::Type, ::ActiveRecord::Type.lookup(:clusterid)
  end
end
