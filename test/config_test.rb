# frozen_string_literal: true

class RailsClusterIdConfigTest < ActiveSupport::TestCase
  setup do
    @config = ::ClusterId::Rails::Config.new
  end

  test "initial generator symbol is default" do
    assert_equal :default, @config.default_generator
  end

  test "adding a non-generator is an error" do
    assert_raises(::ClusterId::Rails::NotAGeneratorError) { @config.add_generator(:default, 1) }
  end

  test "an added generator can be retrieved" do
    g = ::ClusterId::V1::Generator.new
    @config.add_generator(:mine, g)
    assert_equal g, @config.generator(:mine)
  end

  test "looking up an unknown generator raises a KeyError" do
    assert_raises(KeyError) { @config.generator(:unknown) }
  end
end
