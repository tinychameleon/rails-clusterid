# frozen_string_literal: true

require "test_helper"

class RailtieApplicationConfigurationTest < ActiveSupport::TestCase
  test "registers the clusterid configuration object" do
    assert_includes Rails::Application::Configuration.instance_methods, :clusterid
    Rails.application.config.clusterid do |c|
      assert_kind_of ::ClusterId::Rails::Config, c
    end
  end
end
