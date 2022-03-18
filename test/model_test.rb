# frozen_string_literal: true

require "test_helper"

class RailsClusterIdModelTest < ActiveSupport::TestCase
  class Project < ApplicationRecord
    include ::ClusterId::Rails::Model
  end

  class User < ApplicationRecord
    include ::ClusterId::Rails::Model

    def clusterid_generator
      :v1
    end
  end

  setup do
    @model = User.new
  end

  test "uses the default clusterid generator" do
    assert_equal ::ClusterId::Rails::DEFAULT_GENERATOR_NAME, Project.new.send(:clusterid_generator)
  end

  test "assigns an id before creating" do
    @model.save!
    @model.reload
    refute_nil @model.id
    assert_kind_of String, @model.id
  end

  test "multiple models sort properly" do
    User.create!(name: "test_one")
    User.create!(name: "test_two")
    User.create!(name: "test_three")

    query = ->(ord) { User.where("name LIKE 'test_%'").order(id: ord).pluck(:name) }

    assert_equal ["test_three", "test_two", "test_one"], query.call(:desc)
    assert_equal ["test_one", "test_two", "test_three"], query.call(:asc)
  end
end
