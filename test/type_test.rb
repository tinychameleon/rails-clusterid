# encoding: ascii-8bit
# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

class RailsClusterIdTypeTest < ActiveSupport::TestCase
  setup do
    @type = ::ClusterId::Rails::Type.new
  end

  test "is a kind of ActiveRecord Binary" do
    assert_kind_of ::ActiveRecord::Type::Binary, @type
  end

  test "deserializes binary Data to the string value" do
    assert_equal "abc", @type.deserialize(::ClusterId::Rails::Type::Data.new("abc"))
  end

  test "deserialize returns the unescaped byte value when dealing with PostgreSQL" do
    skip if ::ActiveRecord::Type.adapter_name_from(::ActiveRecord::Base) != :postgresql
    ::ActiveRecord::Type.stub :adapter_name_from, :postgresql do
      assert_equal "\x01\x02", @type.deserialize("\\x0102")
    end
  end

  test "deserialize returns the unchanged value when not dealing with PostgreSQL" do
    ::ActiveRecord::Type.stub :adapter_name_from, :mysql2 do
      assert_equal "123", @type.deserialize("123")
    end
  end

  test "serialize returns nil if passed nil" do
    assert_nil @type.serialize(nil)
  end

  test "serialize returns a binary Data with the given value" do
    data = @type.serialize("123")
    assert_kind_of ::ClusterId::Rails::Type::Data, data
    assert_equal "123", data.to_s
  end

  test "serialize decodes Crockford32 values into binary Data values if given one" do
    data = @type.serialize("0123456789ABCDEFGHJKMNPQRS")
    assert_kind_of ::ClusterId::Rails::Type::Data, data
    assert_equal " \x88A\x8A9(\xA9\xC5\x9A{0\xCAI\xAB\xBD8\x03", data.to_s
  end
end
