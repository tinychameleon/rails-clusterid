# frozen_string_literal: true

require "test_helper"

class RailtieActiveRecordTypeTest < ActiveSupport::TestCase
  test "registers the clusterid type" do
    assert_kind_of ::ClusterId::Rails::ClusterIdColumn, ::ActiveRecord::Type.lookup(:clusterid)
  end
end
