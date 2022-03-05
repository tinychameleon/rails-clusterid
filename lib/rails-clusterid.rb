# frozen_string_literal: true

module ClusterId
  module Rails
    DATA_TYPE = :clusterid
  end
end

require_relative "rails-clusterid/version"

module ClusterId::Rails
  class Error < StandardError; end
  # Your code goes here...
end

require_relative "rails-clusterid/datatype"
require_relative "rails-clusterid/railtie"
