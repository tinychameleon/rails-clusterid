# frozen_string_literal: true

require "test_helper"

class RailsClusterIdApplicationConfigTest < ActiveSupport::TestCase
  class Subject
    include ::ClusterId::Rails::ApplicationConfiguration
  end

  setup do
    @subject = Subject.new
  end

  test "responds to the clusterid message" do
    assert_respond_to @subject, :clusterid
  end

  test "returns a Config object" do
    assert_kind_of ::ClusterId::Rails::Config, @subject.clusterid
  end

  test "calls the given block with the Config object" do
    config = nil
    @subject.clusterid { |c| config = c }
    assert_kind_of ::ClusterId::Rails::Config, config
  end
end
