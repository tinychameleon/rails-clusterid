# frozen_string_literal: true

module ClusterId
  module Rails
    DATA_TYPE = :clusterid
  end
end

module ClusterId::Rails
  class Error < StandardError; end

  class NotAGeneratorError < Error; end
end

require "clusterid"
require "crockford32"

require_relative "rails-clusterid/version"
require_relative "rails-clusterid/config"
require_relative "rails-clusterid/datatype"
require_relative "rails-clusterid/railtie"
