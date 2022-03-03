# frozen_string_literal: true

require "test_helper"

class TestRailsClusterId < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ClusterId::Rails::VERSION
  end
end
