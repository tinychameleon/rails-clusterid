# frozen_string_literal: true

require "test_helper"

class RailtieTableDefinitionTest < ActiveSupport::TestCase
  test "it responds to the clusterid data type method" do
    assert_includes ::ActiveRecord::ConnectionAdapters::TableDefinition.instance_methods, :clusterid
  end
end
