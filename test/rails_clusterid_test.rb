# frozen_string_literal: true

require "test_helper"

class RailsClusterIdTest < ActiveSupport::TestCase
  test "it has a version number" do
    refute_nil ClusterId::Rails::VERSION
  end
end
