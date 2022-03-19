# frozen_string_literal: true

require "test_helper"

class RailsClusterIdTest < ActiveSupport::TestCase
  test "it has a version number" do
    refute_nil ClusterId::Rails::VERSION
  end

  test "it has clusterid as a data type" do
    assert_equal :clusterid, ClusterId::Rails::DATA_TYPE
  end

  test "it has default as the default generator name" do
    assert_equal :default, ClusterId::Rails::DEFAULT_GENERATOR_NAME
  end
end
