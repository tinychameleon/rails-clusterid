# frozen_string_literal: true

require "test_helper"

class RailtieNativeDataTypesTest < ActiveSupport::TestCase
  test "uses bytea for postgresql" do
    assert_equal "bytea", ::ClusterId::Rails::NativeDataTypes.database_adapter_to_type("postgresql")
  end

  test "registers the clusterid database type" do
    type_map = ::ActiveRecord::Base.connection.native_database_types
    assert_includes type_map, :clusterid
    assert_includes type_map[:clusterid], :name
    assert_includes ["bytea"], type_map[:clusterid][:name]
  end
end
